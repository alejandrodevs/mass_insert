require 'spec_helper'

describe MassInsert::Builder::Adapters::Helpers::ColumnValue do
  let(:class_name) { User }
  let(:row) {{ :name	=> "name", :age	=> 10 }}
  let(:column){ :name }
  let!(:subject){ MassInsert::Builder::Adapters::Helpers::ColumnValue.new(row, column, class_name) }

  describe "#initialize" do
    it "should assign class_name param to class_name attribute" do
      expect(subject.class_name).to eq(class_name)
    end

    it "should assign column param to column attribute" do
      expect(subject.column).to eq(column)
    end

    it "should assign row param to row attribute" do
      expect(subject.row).to eq(row)
    end
  end

  describe "#column_type" do
    it "should respond to column_type method" do
      expect(subject).to respond_to(:column_type)
    end

    it "should return symbol :string" do
      subject.stub(:class_name).and_return("ClassName")
      subject.class_name.stub(:columns_hash).and_return({"name" => "SomeObject"})
      subject.class_name.columns_hash["name"].stub(:type).and_return(:column_type)
      expect(subject.column_type).to eq(:column_type)
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
      subject.stub(:class_name).and_return("ClassName")
      subject.class_name.stub(:columns_hash).and_return({"name" => "SomeObject"})
      subject.class_name.columns_hash["name"].stub(:default).and_return(:default_db_value)
      expect(subject.default_db_value).to eq(:default_db_value)
    end
  end

  describe "#build" do
    it "should respond to build method" do
      expect(subject).to respond_to(:build)
    end

    context "when column_value is nil" do
      it "should return the default value" do
        subject.stub(:column_value).and_return(nil)
        subject.stub(:default_value).and_return("default_value")
        expect(subject.build).to eq("default_value")
      end
    end

    context "when column_value is not nil" do
      it "should call a method according to column type" do
        subject.stub(:column_type).and_return("string")
        subject.stub(:column_value_string).and_return("column_value_string")
        expect(subject.build).to eq("column_value_string")
      end
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
    method = :"column_value_#{column_type}"

    describe "##{method.to_s}" do
      it "should respond to #{method.to_s} method" do
        expect(subject).to respond_to(method)
      end

      it "should return the column value" do
        subject.stub(:column_value).and_return("name")
        expect(subject.send(method)).to eq("'name'")
      end
    end
  end

  describe "#column_value_integer" do
    it "should respond to column_value_integer method" do
      expect(subject).to respond_to(:column_value_integer)
    end

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

  [:decimal, :float].each do |column_type|
    method = :"column_value_#{column_type}"

    describe "##{method.to_s}" do
      it "should respond to #{method.to_s} method" do
        expect(subject).to respond_to(method)
      end

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

  describe "#column_value_boolean" do
    it "should respond to column_value_boolean method" do
      expect(subject).to respond_to(:column_value_boolean)
    end

    it "should call a method according to database adapter" do
      MassInsert::Builder::Utilities.stub(:adapter).and_return("mysql2")
      subject.stub(:mysql2_column_value_boolean).and_return("boolean_value")
      expect(subject.column_value_boolean).to eq("boolean_value")
    end
  end

  [
    :mysql2,
    :postgresql,
  ].each do |adapter|
    method = :"#{adapter}_column_value_boolean"

    describe "##{method.to_s}" do
      it "should respond to #{method.to_s} method" do
        expect(subject).to respond_to(method)
      end

      context "when column_value method return true value" do
        it "should return true string" do
          subject.stub(:column_value).and_return(true)
          expect(subject.send(method)).to eq("true")
        end
      end

      context "when column_value method return false value" do
        it "should return false string" do
          subject.stub(:column_value).and_return(false)
          expect(subject.send(method)).to eq("false")
        end
      end
    end
  end

  [
    :sqlite3,
    :sqlserver,
  ].each do |adapter|
    method = :"#{adapter}_column_value_boolean"

    describe "##{method.to_s}" do
      it "should respond to sqlite3_column_value_boolean method" do
        expect(subject).to respond_to(:sqlite3_column_value_boolean)
      end

      context "when column_value method return true value" do
        it "should return true string" do
          subject.stub(:column_value).and_return(true)
          expect(subject.sqlite3_column_value_boolean).to eq("1")
        end
      end

      context "when column_value method return false value" do
        it "should return false string" do
          subject.stub(:column_value).and_return(false)
          expect(subject.sqlite3_column_value_boolean).to eq("0")
        end
      end
    end
  end
end
