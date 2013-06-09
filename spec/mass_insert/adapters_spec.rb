require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters do
  it 'should be defined' do
    expect(MassInsert::Adapters).to be
  end

  it 'should define Adapter class' do
    expect(MassInsert::Adapters::Adapter).to be
  end

  it 'should define ColumnValue class' do
    expect(MassInsert::Adapters::AdapterHelpers).to be
  end

  it 'should define MysqlAdapter class' do
    expect(MassInsert::Adapters::Mysql2Adapter).to be
  end

  it 'should define PostgreSQLAdapter class' do
    expect(MassInsert::Adapters::PostgreSQLAdapter).to be
  end

  it 'should define SQLite3Adapter class' do
    expect(MassInsert::Adapters::SQLite3Adapter).to be
  end

  it 'should define SQLServerAdapter class' do
    expect(MassInsert::Adapters::SQLServerAdapter).to be
  end
end
