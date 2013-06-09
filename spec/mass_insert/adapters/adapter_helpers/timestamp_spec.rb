require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::AdapterHelpers::Timestamp do
  let!(:subject){ MassInsert::Adapters::Adapter.new([], {}) }

  describe "#timestamp?" do
    it "should respond_to timestamp? method" do
      expect(subject).to respond_to(:timestamp?)
    end

    context "when respond to timestamp columns" do
      it "should return true" do
        subject.stub(:columns).and_return([:updated_at, :created_at])
        expect(subject.timestamp?).to be_true
      end
    end

    context "when not respond to timestamp columns" do
      it "should return false" do
        subject.stub(:columns).and_return([:created_at])
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

  describe "#timestamp_hash" do
    it "should respond_to timestamp_hash method" do
      expect(subject).to respond_to(:timestamp_hash)
    end

    context "when have high precision" do
      it "should no be equals" do
        timestamp_hash_expected = {
          :created_at => subject.timestamp,
          :updated_at => subject.timestamp
        }
        expect(subject.timestamp_hash).not_to eq(timestamp_hash_expected)
      end
    end

    context "when do not have precision" do
      it "should be equals" do
        subject.stub(:timestamp_format).and_return("%Y-%m-%d %H:%M:%S")
        timestamp_hash_expected = {
          :created_at => subject.timestamp,
          :updated_at => subject.timestamp
        }
        expect(subject.timestamp_hash).to eq(timestamp_hash_expected)
      end
    end
  end
end
