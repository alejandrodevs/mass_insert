require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::QueryExecution do

  before :each do
    @execution = MassInsert::QueryExecution.new("query string")
  end

  subject{ @execution }

  describe "instance methods" do
    describe "#initialize" do
      it "should initialize the query attribute" do
        execution = MassInsert::QueryExecution.new("query_string")
        execution.query.should eq("query_string")
      end
    end

    describe "#execute" do
      it "should respond to execute method" do
        subject.respond_to?(:execute).should be_true
      end

      it "should execute the query string" do
        ActiveRecord::Base.connection.stub(:execute)
        ActiveRecord::Base.connection.should_receive(:execute)
        subject.execute
      end
    end
  end
end
