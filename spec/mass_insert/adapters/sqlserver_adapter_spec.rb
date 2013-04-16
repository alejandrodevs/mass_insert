require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::SQLServerAdapter do
  before :each do
    @adapter = MassInsert::Adapters::SQLServerAdapter.new([], {})
  end

  subject{ @adapter }

  it "should inherit from Adapter class" do
    subject.should be_a(MassInsert::Adapters::Adapter)
  end

  describe "instance methods" do
    describe "#execute" do
      it "should respond to execute method" do
        subject.respond_to?(:execute).should be_true
      end

      context "when have less than 1000 values" do
        it "call methods and returns their values concatenated" do
          subject.values = [{}]
          subject.stub(:begin_string).and_return("a")
          subject.stub(:string_columns).and_return("b")
          subject.stub(:string_values).and_return("c")
          subject.execute.should eq(["abc"])
        end
      end

      context "when have more than 1000 values" do
        it "call methods and returns their values concatenated" do
          subject.values = []
          1500.times{ subject.values << {} }
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
      class_name = MassInsert::Adapters::SQLServerAdapter
      constant   = "MAX_VALUES_PER_INSERTION".to_sym
      class_name.const_defined?(constant).should be_true
    end

    it "should return 1000" do
      class_name = MassInsert::Adapters::SQLServerAdapter
      class_name::MAX_VALUES_PER_INSERTION.should eq(1000)
    end
  end
end
