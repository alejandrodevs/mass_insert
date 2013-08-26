require 'spec_helper'

describe MassInsert::Executer do
  let!(:subject){ MassInsert::Executer.new }

  describe "#execute" do
    before :each do
      @connection = ActiveRecord::Base.connection
      @connection.stub(:execute)
    end

    context "when receives an array without queries" do
      it "doesn't call ActiveRecord::Base.connection.execute" do
        @connection.should_not_receive(:execute)
        subject.execute([])
      end
    end

    context "when receives an array with one query" do
      it "calls ActiveRecord::Base.connection.execute one time" do
        @connection.should_receive(:execute).exactly(1).times
        subject.execute("one")
      end
    end

    context "when receives an array with more than one query" do
      it "calls ActiveRecord::Base.connection.execute two times" do
        @connection.should_receive(:execute).exactly(2).times
        subject.execute(["one", "two"])
      end
    end
  end
end
