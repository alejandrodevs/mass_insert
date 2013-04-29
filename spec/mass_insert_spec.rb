require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert do
  it 'should be defined' do
    expect(MassInsert).to be
  end

  it 'should define Adapters module' do
    expect(MassInsert::Adapters).to be
  end

  it 'should define Base' do
    expect(MassInsert::Base).to be
  end

  it 'should define ProcessControl' do
    expect(MassInsert::ProcessControl).to be
  end

  it 'should define QueryBuilder' do
    expect(MassInsert::QueryBuilder).to be
  end

  it 'should define QueryExecution' do
    expect(MassInsert::QueryExecution).to be
  end
end
