require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::QueryExecution do

  before :each do
    @execution = MassInsert::QueryExecution.new("query string")
  end

  subject{ @execution }

  describe "instance methods" do
    describe "#initialize" do
      context "when params passed is a string" do
        it "query_container should be an array with the param" do
          execution = MassInsert::QueryExecution.new("option")
          execution.query_container.should eq(["option"])
        end
      end

      context "when params passed is an array" do
        it "query_container should be the array passed by param" do
          params = ["option_one", "option_two"]
          execution = MassInsert::QueryExecution.new(params)
          execution.query_container.should eq(params)
        end
      end
    end

    describe "#execute" do
      it "should respond to execute method" do
        subject.respond_to?(:execute).should be_true
      end

      context "when query container has one query" do
        it "should call ActiveRecord execute one time" do
          ActiveRecord::Base.connection.stub(:execute)
          ActiveRecord::Base.connection.should_receive(:execute).exactly(1).times
          subject.execute
        end
      end

      context "when query container is an array with two queries" do
        it "should call ActiveRecord execute one time" do
          subject.query_container = ["query1", "query2"]
          ActiveRecord::Base.connection.stub(:execute)
          ActiveRecord::Base.connection.should_receive(:execute).exactly(2).times
          subject.execute
        end
      end
    end
  end
end
