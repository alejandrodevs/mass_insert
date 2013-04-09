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

  it 'should define Adapters module' do
    MassInsert::Adapters.should be
  end

  it 'should define AdapterHelper class' do
    MassInsert::Adapters::Adapter.should be
  end

  it 'should define MysqlAdapter class' do
    MassInsert::Adapters::MysqlAdapter.should be
  end

  it 'should define Helpers module' do
    MassInsert::Adapters::Helpers.should be
  end

  it 'should define Timestamp module' do
    MassInsert::Adapters::Helpers::Timestamp.should be
  end

  it 'should define Sanitizer module' do
    MassInsert::Adapters::Helpers::Sanitizer.should be
  end
end
