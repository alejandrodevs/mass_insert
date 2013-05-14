require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::ColumnValue do
  before :each do
    @options = {
      :class_name				=> User,
      :table_name				=> "users",
      :primary_key			=> :id,
      :primary_key_mode => :auto
    }
    @row = {
      :name		=> "name",
      :email	=> "email",
      :age		=> 10
    }
    @colum_value = MassInsert::Adapters::ColumnValue.new(@row, :name, @options)
  end

  subject{ @colum_value }

  describe "#initialize" do
    it "should assign options param to option attribute" do
      subject.options.should eq(@options)
    end

    it "should assign column param to column attribute" do
      subject.column.should eq(:name)
    end

    it "should assign row param to row attribute" do
      subject.row.should eq(@row)
    end
  end

  describe "#class_name" do
    it "should respond to class_name method" do
      subject.respond_to?(:class_name).should be_true
    end

    it "should return the class_name in options" do
      subject.class_name.should eq(User)
    end
  end

  describe "#column_type" do
    it "should respond to column_type method" do
      subject.respond_to?(:column_type).should be_true
    end

    context "when is a string column" do
      it "should return symbol :string" do
        subject.column = :name
        subject.column_type.should eq(:string)
      end
    end

    context "when is a integer column" do
      it "should return symbol :integer" do
        subject.column = :age
        subject.column_type.should eq(:integer)
      end
    end
  end

  describe "#colum_value" do
    it "should respond to column_value method" do
      subject.respond_to?(:column_value).should be_true
    end

    it "should return symbol :string" do
      subject.column = :age
      subject.column_value.should eq(10)
    end
  end

  describe "#adapter" do
    it "should respond to adapter method" do
      subject.respond_to?(:adapter).should be_true
    end

    it "should return the adapter type" do
      config = {"config" => {:adapter => "sql"}}
      ActiveRecord::Base.connection.stub(:instance_values).and_return(config)
      subject.adapter.should eq("sql")
    end
  end

  describe "#default_value" do
    it "should respond to default_value method" do
      subject.respond_to?(:default_value).should be_true
    end

    context "when default_db_value is nil" do
      it "should return 'null' string" do
        subject.stub(:default_db_value).and_return(nil)
        subject.default_value.should eq("null")
      end
    end

    context "when default_db_value is not nil" do
      it "should return the correct value" do
        subject.stub(:default_db_value).and_return("default_value")
        subject.default_value.should eq("default_value")
      end
    end
  end

  describe "#default_db_value" do
    it "should respond to default_db_value method" do
      subject.respond_to?(:default_db_value).should be_true
    end

    it "should return the default database value" do
      subject.column = :name
      subject.default_db_value.should eq(nil)
    end
  end

  describe "#build" do
    it "should respond to build method" do
      subject.respond_to?(:build).should be_true
    end

    context "when column_value is nil" do
      it "should return the default value" do
        subject.stub(:column_value).and_return(nil)
        subject.stub(:default_value).and_return("default_value")
        subject.build.should eq("default_value")
      end
    end

    context "when column_value is not nil" do
      it "should call a method according to column type" do
        subject.stub(:column_type).and_return("string")
        subject.stub(:column_value_string).and_return("column_value_string")
        subject.build.should eq("column_value_string")
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
    method = "column_value_#{column_type}".to_sym

    it "should respond to #{method.to_s} method" do
      subject.respond_to?(method).should be_true
    end

    it "should return the column value" do
      subject.stub(:column_value).and_return("name")
      subject.send(method).should eq("'name'")
    end
  end

  describe "#column_value_integer" do
    it "should respond to column_value_integer method" do
      subject.respond_to?(:column_value_integer).should be_true
    end

    context "when is a integer value" do
      it "should return the same integer value" do
        subject.stub(:column_value).and_return(20)
        subject.column_value_integer.should eq("20")
      end
    end

    context "when is not a integer value" do
      it "should convert it to integer value" do
        subject.stub(:column_value).and_return("name")
        subject.column_value_integer.should eq("0")
      end
    end
  end

  [:decimal, :float].each do |column_type|
    method = "column_value_#{column_type}".to_sym

    describe "#column_value_#{method.to_s}" do
      it "should respond to #{method.to_s} method" do
        subject.respond_to?(method).should be_true
      end

      context "when is a decimal value" do
        it "should return the same decimal value" do
          subject.stub(:column_value).and_return(20.5)
          subject.send(method).should eq("20.5")
        end
      end

      context "when is not a decimal value" do
        it "should convert it to decimal value" do
          subject.stub(:column_value).and_return("name")
          subject.send(method).should eq("0.0")
        end
      end
    end
  end

  describe "#column_value_boolean" do
    it "should respond to column_value_boolean method" do
      subject.respond_to?(:column_value_boolean).should be_true
    end

    it "should call a method according to database adapter" do
      subject.stub(:adapter).and_return("mysql2")
      subject.stub(:mysql2_column_value_boolean).and_return("boolean_value")
      subject.column_value_boolean.should eq("boolean_value")
    end
  end

  [
    :mysql2,
    :postgresql,
    :sqlserver,
  ].each do |adapter|
    method = :"#{adapter}_column_value_boolean"

    describe "##{method.to_s}" do
      it "should respond to #{method.to_s} method" do
        subject.respond_to?(method).should be_true
      end

      context "when column_value method return true value" do
        it "should return true string" do
          subject.stub(:column_value).and_return(true)
          subject.send(method).should eq("true")
        end
      end

      context "when column_value method return false value" do
        it "should return false string" do
          subject.stub(:column_value).and_return(false)
          subject.send(method).should eq("false")
        end
      end
    end
  end

  describe "#sqlite3_column_value_boolean" do
    it "should respond to sqlite3_column_value_boolean method" do
      subject.respond_to?(:sqlite3_column_value_boolean).should be_true
    end

    context "when column_value method return true value" do
      it "should return true string" do
        subject.stub(:column_value).and_return(true)
        subject.sqlite3_column_value_boolean.should eq("1")
      end
    end

    context "when column_value method return false value" do
      it "should return false string" do
        subject.stub(:column_value).and_return(false)
        subject.sqlite3_column_value_boolean.should eq("0")
      end
    end
  end
end
