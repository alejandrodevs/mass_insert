require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::QueryExecution do

  before :each do
    @execution = MassInsert::QueryExecution.new("")
  end

  subject{ @execution }

  describe "instance methods" do
    describe "#initialize" do

      before :each do
        @query     = "Some query string"
        @execution = MassInsert::QueryExecution.new(@query)
      end

      it "should initialize the query attribute" do
        @execution.query.should eq(@query)
      end
    end

    describe "#execute" do
      it "should respond to execute method" do
        subject.respond_to?(:execute).should be_true
      end

      it "should execute the query string" do

      end
    end
  end
end
