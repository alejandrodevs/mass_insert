require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Helpers::Timestamp do
  let!(:subject){ MassInsert::Adapters::Adapter.new([], {}) }

  describe "#timestamp?" do
    it "should respond_to timestamp? method" do
      expect(subject).to respond_to(:timestamp?)
    end

    context "when respond to timestamp columns" do
      it "should return true" do
        subject.stub(:column_names).and_return([:updated_at, :created_at])
        expect(subject.timestamp?).to be_true
      end
    end

    context "when not respond to timestamp columns" do
      it "should return false" do
        subject.stub(:column_names).and_return([:created_at])
        expect(subject.timestamp?).to be_false
      end
    end
  end

  describe "#timestamp_format" do
    it "should respond_to timestamp_format method" do
      expect(subject).to respond_to(:timestamp_format)
    end

    it "should return the default timestamp format" do
      expect(subject.timestamp_format).to eq("%Y-%m-%d %H:%M:%S.%6N")
    end
  end

  describe "#timestamp" do
    it "should respond_to timestamp method" do
      expect(subject).to respond_to(:timestamp)
    end

    it "should return the default timestamp value with correct format" do
      subject.stub(:timestamp_format).and_return("%Y-%m-%d %H:%M:%S")
      timestamp_value = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      expect(subject.timestamp).to eq(timestamp_value)
    end
  end

  describe "#timestamp_values" do
    it "should respond_to timestamp_values method" do
      expect(subject).to respond_to(:timestamp_values)
    end

    context "when have high precision" do
      it "should no be equals" do
        timestamp_values = {
          :created_at => subject.timestamp,
          :updated_at => subject.timestamp
        }
        expect(subject.timestamp_values).not_to eq(timestamp_values)
      end
    end

    context "when do not have precision" do
      it "should be equals" do
        subject.stub(:timestamp_format).and_return("%Y-%m-%d %H:%M:%S")
        timestamp_values = {
          :created_at => subject.timestamp,
          :updated_at => subject.timestamp
        }
        expect(subject.timestamp_values).to eq(timestamp_values)
      end
    end
  end
end
