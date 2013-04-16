require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::PostgreSQLAdapter do
  before :each do
    @adapter = MassInsert::Adapters::PostgreSQLAdapter.new([], {})
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

      it "call methods and returns their values concatenated" do
        subject.stub(:begin_string).and_return("a")
        subject.stub(:string_columns).and_return("b")
        subject.stub(:string_values).and_return("c")
        subject.execute.should eq("abc")
      end
    end
  end
end
