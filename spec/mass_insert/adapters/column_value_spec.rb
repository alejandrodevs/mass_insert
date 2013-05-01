require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::ColumnValue do
  let(:options) {{ :class_name	=> User }}
  let(:row) {{ :name	=> "name", :age	=> 10 }}
  let(:column){ :name }
  let!(:subject){ MassInsert::Adapters::ColumnValue.new(row, column, options) }

  describe "#initialize" do
    it "should assign options param to option attribute" do
      expect(subject.options).to eq(options)
    end

    it "should assign column param to column attribute" do
      expect(subject.column).to eq(column)
    end

    it "should assign row param to row attribute" do
      expect(subject.row).to eq(row)
    end
  end

  describe "#class_name" do
    it "should respond to class_name method" do
      expect(subject).to respond_to(:class_name)
    end

    it "should return the class_name in options" do
      expect(subject.class_name).to eq(User)
    end
  end

  describe "#column_type" do
    it "should respond to column_type method" do
      expect(subject).to respond_to(:column_type)
    end

    it "should return symbol :string" do
      expect(subject.column_type).to eq(:string)
    end
  end

  describe "#colum_value" do
    it "should respond to column_value method" do
      expect(subject).to respond_to(:column_value)
    end

    it "should return row value to this column" do
      expect(subject.column_value).to eq("name")
    end
  end

  describe "#adapter" do
    it "should respond to adapter method" do
      expect(subject).to respond_to(:adapter)
    end

    it "should return the adapter type" do
      config = {"config" => {:adapter => "sql"}}
      connection = ActiveRecord::Base.connection
      connection.stub(:instance_values).and_return(config)
      expect(subject.adapter).to eq("sql")
    end
  end

  describe "#default_value" do
    it "should respond to default_value method" do
      expect(subject).to respond_to(:default_value)
    end

    context "when default_db_value is nil" do
      it "should return 'null' string" do
        subject.stub(:default_db_value).and_return(nil)
        expect(subject.default_value).to eq("null")
      end
    end

    context "when default_db_value is not nil" do
      it "should return the correct value" do
        subject.stub(:default_db_value).and_return("default_value")
        expect(subject.default_value).to eq("default_value")
      end
    end
  end

  describe "#default_db_value" do
    it "should respond to default_db_value method" do
      expect(subject).to respond_to(:default_db_value)
    end

    it "should return the default database value" do
      expect(subject.default_db_value).to eq(nil)
    end
  end

  describe "#build" do
    it "should respond to build method" do
      expect(subject).to respond_to(:build)
    end

    it "should call a method according to column type" do
      subject.stub(:column_type).and_return("string")
      subject.stub(:column_value_string).and_return("column_value_string")
      expect(subject.build).to eq("column_value_string")
    end
  end

  [
    :string,
    :text,
    :date,
    :time,
    :datetime,
    :timestamp,
    :binary
  ].each do |column_type|
    method = "column_value_#{column_type}".to_sym

    describe "#column_value_#{method.to_s}" do
      it "should respond to #{method.to_s} method" do
        expect(subject).to respond_to(method)
      end

      context "when column_value is nil" do
        it "should return the default value" do
          subject.stub(:column_value).and_return(nil)
          subject.stub(:default_value).and_return("default_value")
          expect(subject.send(method)).to eq("default_value")
        end
      end

      context "when column_value is not nil" do
        it "should return the column value" do
          subject.stub(:column_value).and_return("name")
          expect(subject.send(method)).to eq("'name'")
        end
      end
    end
  end

  describe "#column_value_integer" do
    it "should respond to column_value_integer method" do
      expect(subject).to respond_to(:column_value_integer)
    end

    context "when column_value is nil" do
      it "should return the default value" do
        subject.stub(:column_value).and_return(nil)
        subject.stub(:default_value).and_return("default_value")
        expect(subject.column_value_integer).to eq("default_value")
      end
    end

    context "when column_value is not nil" do
      context "when is a integer value" do
        it "should return the same integer value" do
          subject.stub(:column_value).and_return(20)
          expect(subject.column_value_integer).to eq("20")
        end
      end

      context "when is not a integer value" do
        it "should convert it to integer value" do
          subject.stub(:column_value).and_return("name")
          expect(subject.column_value_integer).to eq("0")
        end
      end
    end
  end

  [:decimal, :float].each do |column_type|
    method = "column_value_#{column_type}".to_sym

    describe "#column_value_#{method.to_s}" do
      it "should respond to #{method.to_s} method" do
        expect(subject).to respond_to(method)
      end

      context "when column_value is nil" do
        it "should return the default value" do
          subject.stub(:column_value).and_return(nil)
          subject.stub(:default_value).and_return("default_value")
          expect(subject.send(method)).to eq("default_value")
        end
      end

      context "when column_value is not nil" do
        context "when is a decimal value" do
          it "should return the same decimal value" do
            subject.stub(:column_value).and_return(20.5)
            expect(subject.send(method)).to eq("20.5")
          end
        end

        context "when is not a decimal value" do
          it "should convert it to decimal value" do
            subject.stub(:column_value).and_return("name")
            expect(subject.send(method)).to eq("0.0")
          end
        end
      end
    end
  end

  describe "#column_value_boolean" do
    it "should respond to column_value_boolean method" do
      expect(subject).to respond_to(:column_value_boolean)
    end

    context "when adapter is mysql2, postgresql or sqlserve" do
      before :each do
        subject.stub(:adapter).and_return("mysql2")
      end

      context "when column value is nil" do
        it "should return database default value" do
          subject.stub(:column_value).and_return(nil)
          subject.stub(:default_value).and_return("default_value")
          expect(subject.column_value_boolean).to eq("default_value")
        end
      end

      context "when column value is not nil" do
        context "when column value is false" do
          it "should return 'false' string" do
            subject.stub(:column_value).and_return(false)
            expect(subject.column_value_boolean).to eq("false")
          end
        end

        context "when column value is true" do
          it "should return 'true' string" do
            subject.stub(:column_value).and_return(true)
            expect(subject.column_value_boolean).to eq("true")
          end
        end
      end
    end

    context "when adapter is sqlite3" do
      before :each do
        subject.stub(:adapter).and_return("sqlite3")
      end

      context "when column value is nil" do
        it "should return database default value" do
          subject.stub(:column_value).and_return(nil)
          subject.stub(:default_value).and_return("default_value")
          expect(subject.column_value_boolean).to eq("default_value")
        end
      end

      context "when column value is not nil" do
        context "when column value is false" do
          it "should return '0' string" do
            subject.stub(:column_value).and_return(false)
            expect(subject.column_value_boolean).to eq("0")
          end
        end

        context "when column value is true" do
          it "should return '1' string" do
            subject.stub(:column_value).and_return(true)
            expect(subject.column_value_boolean).to eq("1")
          end
        end
      end
    end
  end
end
