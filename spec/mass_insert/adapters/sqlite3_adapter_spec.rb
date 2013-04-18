require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::SQLite3Adapter do
  before :each do
    @adapter = MassInsert::Adapters::SQLite3Adapter.new([], {})
  end

  subject{ @adapter }

  it "should inherit from Adapter class" do
    subject.should be_a(MassInsert::Adapters::Adapter)
  end

  describe "instance methods" do
    describe "#string_values" do
      it "should respond to string_values method" do
        subject.respond_to?(:string_values).should be_true
      end

      it "should returns correct string to values" do
        subject.stub(:string_rows_values).and_return("string_rows_values")
        subject.string_values.should eq("SELECT string_rows_values;")
      end
    end

    describe "#string_rows_values" do
      it "should respond to string_rows_values method" do
        subject.respond_to?(:string_rows_values).should be_true
      end

      context "when only have one value hash" do
        it "should returns the correct string" do
          subject.stub(:string_single_row_values).and_return("single_row")
          subject.values = [{}]
          subject.string_rows_values.should eq("single_row")
        end
      end

      context "when have two or more value hashes" do
        it "should returns the correct string" do
          subject.stub(:string_single_row_values).and_return("single_row")
          subject.values = [{}, {}]
          string = "single_row UNION SELECT single_row"
          subject.string_rows_values.should eq(string)
        end
      end
    end

    describe "#execute" do
      it "should respond to execute method" do
        subject.respond_to?(:execute).should be_true
      end

      context "when have less than 500 values" do
        it "call methods and returns their values concatenated" do
          subject.values = [{}]
          subject.stub(:begin_string).and_return("a")
          subject.stub(:string_columns).and_return("b")
          subject.stub(:string_values).and_return("c")
          subject.execute.should eq(["abc"])
        end
      end

      context "when have more than 500 values" do
        it "call methods and returns their values concatenated" do
          subject.values = []
          800.times{ subject.values << {} }
          subject.stub(:begin_string).and_return("a")
          subject.stub(:string_columns).and_return("b")
          subject.stub(:string_values).and_return("c")
          subject.execute.should eq(["abc", "abc"])
        end
      end
    end
  end

  describe "MAX_VALUES_PER_INSERTION" do
    it "should respond_to" do
      class_name = MassInsert::Adapters::SQLite3Adapter
      constant   = "MAX_VALUES_PER_INSERTION".to_sym
      class_name.const_defined?(constant).should be_true
    end

    it "should return 1000" do
      class_name = MassInsert::Adapters::SQLite3Adapter
      class_name::MAX_VALUES_PER_INSERTION.should eq(500)
    end
  end
end
