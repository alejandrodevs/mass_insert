require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Execution do

  before :each do
    @execution = MassInsert::Execution.new([], {})
  end

  subject{ @execution }

  describe "instance methods" do
    describe "initialize" do

      before :each do
        @values  = [{:name => "name"}]
        @options = {:option_one => 10}
        @execution = MassInsert::Execution.new(@values, @options)
      end

      it "should initialize the values" do
        @execution.values.should eq(@values)
      end

      it "should initialize the options" do
        @execution.options.should eq(@options)
      end
    end

    describe "execute" do
      it "respond to" do
        subject.respond_to?(:execute).should be_true
      end
    end

    describe "start" do
      it "respond to" do
        subject.respond_to?(:start).should be_true
      end
    end

    describe "query" do
      it "respond to" do
        subject.respond_to?(:query).should be_true
      end
    end
  end
end
