require 'spec_helper'

describe MassInsert::Executer::Base do
  let!(:subject){ MassInsert::Executer::Base.new("query string") }

  describe "instance methods" do
    describe "#initialize" do
      context "when params passed is a string" do
        it "query_container should be an array with the param" do
          execution = MassInsert::Executer::Base.new("option")
          expect(execution.query_container).to eq(["option"])
        end
      end

      context "when params passed is an array" do
        it "query_container should be the array passed by param" do
          execution = MassInsert::Executer::Base.new(["one", "two"])
          expect(execution.query_container).to eq(["one", "two"])
        end
      end
    end

    describe "#execute" do
      before :each do
        @connection = ActiveRecord::Base.connection
        @connection.stub(:execute)
      end

      it "should respond to execute method" do
        expect(subject).to respond_to(:execute)
      end

      context "when query container has one query" do
        it "should call ActiveRecord execute one time" do
          @connection.should_receive(:execute).exactly(1).times
          subject.execute
        end
      end

      context "when query container is an array with two queries" do
        it "should call ActiveRecord execute one time" do
          subject.query_container = ["one", "two"]
          @connection.should_receive(:execute).exactly(2).times
          subject.execute
        end
      end
    end
  end
end
