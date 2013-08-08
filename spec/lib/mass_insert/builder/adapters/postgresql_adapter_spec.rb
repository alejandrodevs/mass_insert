require 'spec_helper'

describe MassInsert::Builder::Adapters::PostgreSQLAdapter do
  let!(:subject){ MassInsert::Builder::Adapters::PostgreSQLAdapter.new([], {}) }

  it "should inherit from Adapter class" do
    expect(subject).to be_a(MassInsert::Builder::Adapters::Adapter)
  end

end
