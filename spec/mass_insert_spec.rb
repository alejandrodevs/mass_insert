require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert do
  it 'should be defined' do
    should be
  end

  it 'should define Adapters module' do
    MassInsert::Adapters.should be
  end

  it 'should define Base' do
    MassInsert::Base.should be
  end

  it 'should define ProcessControl' do
    MassInsert::ProcessControl.should be
  end

  it 'should define QueryBuilder' do
    MassInsert::QueryBuilder.should be
  end

  it 'should define QueryExecution' do
    MassInsert::QueryExecution.should be
  end
end
