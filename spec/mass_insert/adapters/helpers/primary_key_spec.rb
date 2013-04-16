require './spec/spec_helper'
require "./lib/mass_insert"
require "./spec/dummy_models/test"

describe MassInsert::Adapters::Helpers::PrimaryKey do

  before :each do
    @adapter = MassInsert::Adapters::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "#counter_primary_key" do
    it "should respond to counter_primary_key method" do
      subject.respond_to?(:counter_primary_key).should be_true
    end

    context "when it is initialized" do
      it "should return the value in counter_primary_key attribute" do
        subject.counter_primary_key = 10
        subject.counter_primary_key.should eq(10)
      end
    end

    context "when it is not initialized" do
      it "should return the last primary_key value" do
        subject.counter_primary_key = nil
        subject.options.merge!(:class_name  => Test)
        subject.options.merge!(:primary_key => :id)
        Test.stub(:last).and_return([])
        Test.last.stub(subject.primary_key).and_return(3)
        subject.counter_primary_key.should eq(3)
      end
    end
  end

  describe "#primary_key_value" do
    it "should respond to primary_key_value method" do
      subject.respond_to?(:primary_key_value).should be_true
    end

    it "should increase counter_primary_key by 1" do
      subject.counter_primary_key = 2
      subject.primary_key_value
      subject.counter_primary_key.should eq(3)
    end

    it "should return a hash with primary key value" do
      subject.counter_primary_key = 5
      subject.options.merge!(:primary_key => :test_id)
      subject.primary_key_value.should eq({:test_id => 6})
    end
  end

end
