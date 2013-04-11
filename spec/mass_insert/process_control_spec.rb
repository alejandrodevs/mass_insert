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
    end
  end
end
