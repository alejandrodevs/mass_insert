require 'spec_helper'

describe MassInsert::Builder::Adapters::SQLite3Adapter do
  let!(:subject){ described_class.new([], {}) }

  it "inherits from Adapter class" do
    expect(described_class < MassInsert::Builder::Adapters::Adapter).to eql true
  end

  describe "#values_per_insertion" do
    context "when each_slice option isn't false" do
      it "returns each_slice option value" do
        subject.options.merge!(each_slice: 10)
        expect(subject.values_per_insertion).to eq(10)
      end
    end

    context "when each_slice option is false" do
      it "returns 500" do
        subject.options.merge!(each_slice: false)
        expect(subject.values_per_insertion).to eq(500)
      end
    end
  end

  describe "#string_values" do
    it "returns the correct values string" do
      subject.stub(:string_rows_values).and_return("rows_values")
      expect(subject.string_values).to eq("SELECT rows_values;")
    end
  end

  describe "#string_rows_values" do
    before :each do
      subject.stub(:string_single_row_values).and_return("row_values")
    end

    context "when is one value" do
      it "returns the correct string" do
        subject.values = [{}]
        expect(subject.string_rows_values).to eq("row_values")
      end
    end

    context "when are two values" do
      it "returns the correct string" do
        subject.values = [{}, {}]
        expect(subject.string_rows_values).to eq("row_values UNION SELECT row_values")
      end
    end
  end
end
