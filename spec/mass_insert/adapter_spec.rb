require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapter do
  before :each do
    @adapter = MassInsert::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "instance methods" do
    describe "initialize" do

      before :each do
        @values  = [{:name => "name"}]
        @options = {:option_one => 10}
        @adapter = MassInsert::Adapter.new(@values, @options)
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

    describe "columns" do
      it "should returns the table columns in order" do
        subject.stub(:table_columns).and_return(["a", "c", "b"])
        subject.columns.should eq(["a", "b", "c"])
      end
    end

    describe "sanitize_primary_key_column" do

      before :each do
        subject.options = {
          :primary_key      => "id",
          :primary_key_mode => "automatic",
        }
        subject.stub(:columns).and_return(["id", "name"])
      end

      context "when primary_key_mode is automatic" do
        it "should returns the columns without primary_key" do
          subject.sanitize_primary_key_column
          subject.columns.should eq(["name"])
        end
      end

      context "when primary_key_mode is not automatic" do
        it "should returns the columns without primary_key" do
          subject.options.merge!(:primary_key_mode => "manually")
          subject.sanitize_primary_key_column
          subject.columns.should eq(["id", "name"])
        end
      end
    end

    describe "timestamp?" do
      context "when respond to timestamp columns" do
        it "should return true" do
          subject.stub(:columns).and_return(["updated_at", "created_at"])
          subject.timestamp?.should be_true
        end
      end

      context "when not respond to timestamp columns" do
        it "should return false" do
          subject.stub(:columns).and_return(["created_at"])
          subject.timestamp?.should be_false
        end
      end
    end

    describe "set_timestamps_columns" do
      it "should merge to raw the timestamp values" do
        raw = {:name => "name", :email => "email"}
        subject.set_timestamps_columns(raw)
        raw.has_key?(:created_at).should be_true
        raw.has_key?(:updated_at).should be_true
      end
    end
  end
end
