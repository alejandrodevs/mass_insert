require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Helpers do
  it 'should be defined' do
    should be
  end

  it 'should define Timestamp module' do
    MassInsert::Adapters::Helpers::Timestamp.should be
  end

  it 'should define Sanitizer module' do
    MassInsert::Adapters::Helpers::Sanitizer.should be
  end
end
