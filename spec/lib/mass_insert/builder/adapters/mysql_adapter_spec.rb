require 'spec_helper'

describe MassInsert::Builder::Adapters::Mysql2Adapter do
  let!(:subject){ described_class.new([], {}) }

  it "inherits from Adapter class" do
    expect(described_class < MassInsert::Builder::Adapters::Adapter).to eql true
  end
end
