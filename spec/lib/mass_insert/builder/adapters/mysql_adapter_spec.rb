require 'spec_helper'

describe MassInsert::Builder::Adapters::Mysql2Adapter do
  let!(:subject){ described_class.new([], {}) }

  it "inherits from Adapter class" do
    expect(described_class < MassInsert::Builder::Adapters::Adapter).to be_true
  end

  describe "#timestamp_format" do
    it "returns format string" do
      expect(subject.timestamp_format).to eq("%Y-%m-%d %H:%M:%S")
    end
  end
end
