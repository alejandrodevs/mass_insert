require 'spec_helper'

describe MassInsert::Builder::Adapters::SQLServerAdapter do
  let!(:subject){ described_class.new([], {}) }

  it "inherits from Adapter class" do
    expect(described_class < MassInsert::Builder::Adapters::Adapter).to eql true
  end

  describe "#string_columns" do
    it "returns the correct columns string to SQLServer" do
      subject.stub(:columns).and_return([:name, :email])
      expect(subject.string_columns).to eq("([name], [email]) ")
    end
  end

  describe "#values_per_insertion" do
    context "when each_slice option isn't false" do
      it "returns each_slice option value" do
        subject.options.merge!(each_slice: 10)
        expect(subject.values_per_insertion).to eq(10)
      end
    end

    context "when each_slice option is false" do
      it "returns 1000" do
        subject.options.merge!(each_slice: false)
        expect(subject.values_per_insertion).to eq(1000)
      end
    end
  end
end
