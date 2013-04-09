require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert do
  it 'should be defined' do
    should be
  end

  it 'should define Base' do
    MassInsert::Base.should be
  end

  it 'should define Execution' do
    MassInsert::Execution.should be
  end

  it 'should define Adapter' do
    MassInsert::Adapter.should be
  end
end
