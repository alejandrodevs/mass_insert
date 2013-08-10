require 'spec_helper'

describe MassInsert::Executer do
  let!(:subject){ MassInsert::Executer.new }

  describe "instance methods" do
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
          subject.execute(["one"])
        end
      end

      context "when query container is an array with two queries" do
        it "should call ActiveRecord execute one time" do
          @connection.should_receive(:execute).exactly(2).times
          subject.execute(["one", "two"])
        end
      end
    end
  end
end
