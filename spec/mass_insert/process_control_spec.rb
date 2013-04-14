require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::ProcessControl do

  before :each do
    @process = MassInsert::ProcessControl.new([], {})
  end

  subject{ @process }

  describe "instance methods" do
    describe "#initialize" do

      before :each do
        @values  = [{:name => "name"}]
        @options = {:option_one => 10}
        @process = MassInsert::ProcessControl.new(@values, @options)
      end

      it "should initialize the values" do
        @process.values.should eq(@values)
      end

      it "should initialize the options" do
        @process.options.should eq(@options)
      end
    end

    describe "#execute" do
      it "should respond to execute method" do
        subject.respond_to?(:execute).should be_true
      end

      it "should instance and call QueryExecution class" do
        subject.stub(:query).and_return("query")
        execution = MassInsert::QueryExecution.any_instance
        execution.stub(:execute).and_return("executed")
        execution.should_receive(:execute).exactly(1).times
        subject.execute
      end
    end

    describe "#query" do
      it "should respond to query method" do
        subject.respond_to?(:query).should be_true
      end

      it "should instance and call QueryBuilder class" do
        builder = MassInsert::QueryBuilder.any_instance
        builder.stub(:build).and_return("query")
        subject.query.should eq("query")
      end
    end
  end
end
