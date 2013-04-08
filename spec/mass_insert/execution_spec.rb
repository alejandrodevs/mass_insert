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

    describe "table_name" do
      it "respond to" do
        subject.respond_to?(:table_name).should be_true
      end

      it "should return the correct value" do
        execution = MassInsert::Execution.new([], {:table_name => "users"})
        execution.table_name.should eq("users")
      end
    end

    describe "class_name" do
      it "respond to" do
        subject.respond_to?(:class_name).should be_true
      end

      it "should return the correct value" do
        execution = MassInsert::Execution.new([], {:class_name => "User"})
        execution.class_name.should eq("User")
      end
    end

    describe "adapter" do
      it "respond to" do
        subject.respond_to?(:adapter).should be_true
      end
    end

    describe "generate_query" do
      it "respond to" do
        subject.respond_to?(:generate_query).should be_true
      end
    end
  end
end
