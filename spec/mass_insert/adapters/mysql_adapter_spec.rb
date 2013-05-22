require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Mysql2Adapter do
  let!(:subject){ MassInsert::Adapters::Mysql2Adapter.new([], {}) }

  it "should inherit from Adapter class" do
    expect(subject).to be_a(MassInsert::Adapters::Adapter)
  end

  describe "instance methods" do
    describe "#timestamp_format" do
      it "should respond to timestamp_format method" do
        expect(subject).to respond_to(:timestamp_format)
      end

      it "should return the format string" do
        expect(subject.timestamp_format).to eq("%Y-%m-%d %H:%M:%S")
      end
    end
  end
end
