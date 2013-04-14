require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert do
  it 'should be defined' do
    should be
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

  it 'should define Adapters module' do
    MassInsert::Adapters.should be
  end

  it 'should define Adapter class' do
    MassInsert::Adapters::Adapter.should be
  end

  it 'should define AbstractQuery class' do
    MassInsert::Adapters::AbstractQuery.should be
  end

  it 'should define MysqlAdapter class' do
    MassInsert::Adapters::Mysql2Adapter.should be
  end

  it 'should define PostgreSQLAdapter class' do
    MassInsert::Adapters::PostgreSQLAdapter.should be
  end

  it 'should define SQLite3Adapter class' do
    MassInsert::Adapters::SQLite3Adapter.should be
  end

  it 'should define SQLServerAdapter class' do
    MassInsert::Adapters::SQLServerAdapter.should be
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
