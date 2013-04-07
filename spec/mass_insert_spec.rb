require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert do
  it 'should be defined' do
    should be
  end

  it 'should define Base' do
    MassInsert::Base.should be
  end
end
