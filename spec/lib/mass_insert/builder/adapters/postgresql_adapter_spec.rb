require 'spec_helper'

describe MassInsert::Builder::Adapters::PostgreSQLAdapter do
  let!(:subject){ described_class.new([], {}) }

  it "inherits from Adapter class" do
    expect(described_class < MassInsert::Builder::Adapters::Adapter).to eql true
  end
end
