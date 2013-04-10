require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Adapter do
  before :each do
    @adapter = MassInsert::Adapters::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "instance methods" do
    describe "initialize" do

      before :each do
        @values  = [{:name => "name"}]
        @options = {:option_one => 10}
        @adapter = MassInsert::Adapters::Adapter.new(@values, @options)
      end

      it "should initialize the values" do
        @adapter.values.should eq(@values)
      end

      it "should initialize the options" do
        @adapter.options.should eq(@options)
      end
    end

    describe "class_name" do
      it "should returns the class_name in options" do
        subject.options = {:class_name => "User"}
        subject.class_name.should eq("User")
      end
    end

    describe "table_name" do
      it "should returns the table_name in options" do
        subject.options = {:table_name => "users"}
        subject.table_name.should eq("users")
      end
    end

    describe "column_names" do
      it "should respond to column_names method" do
        subject.respond_to?(:column_names).should be_true
      end
    end

    describe "sanitize_primary_key_column" do

      before :each do
        subject.options = {
          :primary_key      => :id,
          :primary_key_mode => :auto,
        }
        subject.stub(:column_names).and_return([:id, :name])
      end

      context "when primary_key_mode is automatic" do
        it "should returns the column names without primary_key" do
          subject.sanitize_primary_key_column
          subject.column_names.should eq([:name])
        end
      end

      context "when primary_key_mode is not automatic" do
        it "should returns the column names with primary_key" do
          subject.options.merge!(:primary_key_mode => "manually")
          subject.sanitize_primary_key_column
          subject.column_names.should eq([:id, :name])
        end
      end
    end

    describe "timestamp?" do
      context "when respond to timestamp columns" do
        it "should return true" do
          subject.stub(:column_names).and_return([:updated_at, :created_at])
          subject.timestamp?.should be_true
        end
      end

      context "when not respond to timestamp columns" do
        it "should return false" do
          subject.stub(:column_names).and_return(["created_at"])
          subject.timestamp?.should be_false
        end
      end
    end

    describe "set_timestamps_columns" do
      it "should merge to row the timestamp values" do
        row = {:name => "name", :email => "email"}
        subject.set_timestamps_columns(row)
        row.has_key?(:created_at).should be_true
        row.has_key?(:updated_at).should be_true
      end
    end
  end
end
