require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::PostgreSQLAdapter do
  let!(:subject){ MassInsert::Adapters::PostgreSQLAdapter.new([], {}) }

  it "should inherit from Adapter class" do
    expect(subject).to be_a(MassInsert::Adapters::Adapter)
  end

end
