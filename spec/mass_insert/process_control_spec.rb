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

    describe "#start" do
      before :each do
        subject.stub(:build_query).and_return(true)
        subject.stub(:execute_query).and_return(true)
      end

      it "should respond to start method" do
        subject.respond_to?(:start).should be_true
      end

      it "should call build_query" do
        subject.should_receive(:build_query).exactly(1).times
        subject.start
      end

      it "should define instance variable @build_time" do
        subject.start
        subject.instance_variables.include?(:@build_time).should be_true
      end

      it "should call execute_query" do
        subject.should_receive(:execute_query).exactly(1).times
        subject.start
      end

      it "should define instance variable @execute_time" do
        subject.start
        subject.instance_variables.include?(:@execute_time).should be_true
      end
    end

    describe "#execute_query" do
      it "should respond to execute_query method" do
        subject.respond_to?(:execute_query).should be_true
      end

      context "when query instance variable exists" do
        it "should instance and call QueryExecution class" do
          subject.instance_variable_set(:@query, "query")
          execution = MassInsert::QueryExecution.any_instance
          execution.stub(:execute).and_return("executed")
          execution.should_receive(:execute).exactly(1).times
          subject.execute_query
        end
      end

      context "when query instance variable does not exists" do
        it "should instance and call QueryExecution class" do
          subject.instance_variable_set(:@query, nil)
          execution = MassInsert::QueryExecution.any_instance
          execution.stub(:execute).and_return("executed")
          execution.should_not_receive(:execute)
          subject.execute_query
        end
      end
    end

    describe "#build_query" do
      it "should respond to build_query method" do
        subject.respond_to?(:build_query).should be_true
      end

      it "should instance and call QueryBuilder class" do
        builder = MassInsert::QueryBuilder.any_instance
        builder.stub(:build).and_return("query")
        subject.build_query.should eq("query")
      end

      it "should set query instance variable" do
        builder = MassInsert::QueryBuilder.any_instance
        builder.stub(:build).and_return("query")
        subject.build_query
        subject.instance_variables.include?(:@query).should be_true
      end
    end
  end

  describe "#results" do
    before :each do
      subject.stub(:values).and_return([{}, {}])
      subject.instance_variable_set(:@build_time, 10)
      subject.instance_variable_set(:@execute_time, 20)
    end

    it "should return total time in results" do
      subject.results.time.should eql(30)
    end

    it "should return records persisted in results" do
      subject.results.records.should eql(2)
    end

    it "should return build time in results" do
      subject.results.build_time.should eql(10)
    end

    it "should return execute time in results" do
      subject.results.execute_time.should eql(20)
    end
  end
end
