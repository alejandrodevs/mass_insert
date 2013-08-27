require 'spec_helper'

describe MassInsert::Builder::Adapters::SQLite3Adapter do
  let!(:subject){ MassInsert::Builder::Adapters::SQLite3Adapter.new([], {}) }

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
        expect(subject.values_per_insertion).to eq(500)
      end
    end
  end

  describe "#string_values" do
    it "returns correct values string" do
      subject.stub(:string_rows_values).and_return("rows_values")
      expect(subject.string_values).to eq("SELECT rows_values;")
    end
  end

  describe "#string_rows_values" do
    context "when have one value" do
      it "returns the correct string" do
        subject.stub(:string_single_row_values).and_return("row")
        subject.values = [{}]
        expect(subject.string_rows_values).to eq("row")
      end
    end

    context "when have two values" do
      it "returns the correct string" do
        subject.stub(:string_single_row_values).and_return("row")
        subject.values = [{}, {}]
        expect(subject.string_rows_values).to eq("row UNION SELECT row")
      end
    end
  end
end
