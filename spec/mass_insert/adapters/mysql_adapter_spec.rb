require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Mysql2Adapter do
  before :each do
    @adapter = MassInsert::Adapters::Mysql2Adapter.new([], {})
  end

  subject{ @adapter }

  it "should inherit from Adapter class" do
    subject.should be_a(MassInsert::Adapters::Adapter)
  end

  describe "instance methods" do
    describe "#timestamp_format" do
      it "should respond to timestamp_format method" do
        subject.respond_to?(:timestamp_format).should be_true
      end

      it "should return the format string" do
        subject.timestamp_format.should eq("%Y-%m-%d %H:%M:%S")
      end
    end

    describe "#execute" do
      it "should respond to execute method" do
        subject.respond_to?(:execute).should be_true
      end

      it "call methods and returns their values concatenated" do
        subject.stub(:begin_string).and_return("a")
        subject.stub(:string_columns).and_return("b")
        subject.stub(:string_values).and_return("c")
        subject.execute.should eq("abc")
      end
    end
  end
end
