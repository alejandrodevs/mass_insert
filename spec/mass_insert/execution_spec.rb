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

    describe "generate_sql" do
      it "respond to" do
        subject.respond_to?(:generate_sql).should be_true
      end
    end

    describe "adapter" do
      it "respond to" do
        subject.respond_to?(:adapter).should be_true
      end
    end

    describe "adapter_instance_class" do
      it "respond to" do
        subject.respond_to?(:generate_sql).should be_true
      end

      context "when adapter is mysql" do
        it "should return a Mysql Adapter instance" do
          subject.stub(:adapter).and_return("mysql")
          instance_class = MassInsert::Adapters::MysqlAdapter
          subject.adapter_instance_class.class.should be(instance_class)
        end
      end

      context "when adapter is mysql2" do
        it "should return a Mysql2 Adapter instance" do
          subject.stub(:adapter).and_return("mysql2")
          instance_class = MassInsert::Adapters::MysqlAdapter
          subject.adapter_instance_class.class.should be(instance_class)
        end
      end
    end
  end
end
