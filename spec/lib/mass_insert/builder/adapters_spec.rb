require 'spec_helper'

describe MassInsert::Builder::Adapters do
  it 'should be defined' do
    expect(MassInsert::Builder::Adapters).to be
  end

  it 'should define Adapter class' do
    expect(MassInsert::Builder::Adapters::Adapter).to be
  end

  it 'should define ColumnValue class' do
    expect(MassInsert::Builder::Adapters::AdapterHelpers).to be
  end

  it 'should define MysqlAdapter class' do
    expect(MassInsert::Builder::Adapters::Mysql2Adapter).to be
  end

  it 'should define PostgreSQLAdapter class' do
    expect(MassInsert::Builder::Adapters::PostgreSQLAdapter).to be
  end

  it 'should define SQLite3Adapter class' do
    expect(MassInsert::Builder::Adapters::SQLite3Adapter).to be
  end

  it 'should define SQLServerAdapter class' do
    expect(MassInsert::Builder::Adapters::SQLServerAdapter).to be
  end
end
