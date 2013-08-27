require 'spec_helper'

describe MassInsert::Builder::Adapters::SQLServerAdapter do
  let!(:subject){ MassInsert::Builder::Adapters::SQLServerAdapter.new([], {}) }

  it "inherits from Adapter class" do
    expect(described_class < MassInsert::Builder::Adapters::Adapter).to be_true
  end

  describe "#values_per_insertion" do
    context "when each_slice option is not false" do
      it "returns each_slice value" do
        subject.options.merge!(each_slice: 10)
        expect(subject.values_per_insertion).to eq(10)
      end
    end

    context "when each_slice option is false" do
      it "returns length of values" do
        subject.values = [{}, {}]
        subject.options.merge!(each_slice: false)
        expect(subject.values_per_insertion).to eq(1000)
      end
    end
  end

  describe "#timestamp_format" do
    it "returns format string" do
      expect(subject.timestamp_format).to eq("%Y-%m-%d %H:%M:%S.%3N")
    end
  end
end
