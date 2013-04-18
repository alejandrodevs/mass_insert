require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Helpers::Timestamp do
  before :each do
    @adapter = MassInsert::Adapters::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "#timestamp?" do
    it "should respond_to timestamp? method" do
      subject.respond_to?(:timestamp?).should be_true
    end

    context "when respond to timestamp columns" do
      it "should return true" do
        subject.stub(:column_names).and_return([:updated_at, :created_at])
        subject.timestamp?.should be_true
      end
    end

    context "when not respond to timestamp columns" do
      it "should return false" do
        subject.stub(:column_names).and_return([:created_at])
        subject.timestamp?.should be_false
      end
    end
  end

  describe "#timestamp_format" do
    it "should respond_to timestamp_format method" do
      subject.respond_to?(:timestamp_format).should be_true
    end

    it "should return the default timestamp format" do
      subject.timestamp_format.should eq("%Y-%m-%d %H:%M:%S.%6N")
    end
  end

  describe "#timestamp" do
    it "should respond_to timestamp method" do
      subject.respond_to?(:timestamp).should be_true
    end

    it "should return the default timestamp value with correct format" do
      subject.stub(:timestamp_format).and_return("%Y-%m-%d %H:%M:%S")
      timestamp_value = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      subject.timestamp.should eq(timestamp_value)
    end
  end

  describe "#timestamp_values" do
    it "should respond_to timestamp_values method" do
      subject.respond_to?(:timestamp_values).should be_true
    end

    context "when have high precision" do
      it "should no be equals" do
        timestamp_values = {
          :created_at => subject.timestamp,
          :updated_at => subject.timestamp
        }
        subject.timestamp_values.should_not eq(timestamp_values)
      end
    end

    context "when do not have precision" do
      it "should be equals" do
        subject.stub(:timestamp_format).and_return("%Y-%m-%d %H:%M:%S")
        timestamp_values = {
          :created_at => subject.timestamp,
          :updated_at => subject.timestamp
        }
        subject.timestamp_values.should eq(timestamp_values)
      end
    end
  end
end
