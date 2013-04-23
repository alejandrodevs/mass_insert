require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters do
  it 'should be defined' do
    should be
  end

  it 'should define Adapter class' do
    MassInsert::Adapters::Adapter.should be
  end

  it 'should define ColumnValue class' do
    MassInsert::Adapters::ColumnValue.should be
  end

  it 'should define ColumnValue class' do
    MassInsert::Adapters::Helpers.should be
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
end
