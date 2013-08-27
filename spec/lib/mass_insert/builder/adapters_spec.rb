require 'spec_helper'

describe MassInsert::Builder::Adapters do
  it 'loads Adapter class' do
    expect(described_class::Adapter).to be
  end

  it 'loads MysqlAdapter class' do
    expect(described_class::Mysql2Adapter).to be
  end

  it 'loads PostgreSQLAdapter class' do
    expect(described_class::PostgreSQLAdapter).to be
  end

  it 'loads SQLite3Adapter class' do
    expect(described_class::SQLite3Adapter).to be
  end

  it 'loads SQLServerAdapter class' do
    expect(described_class::SQLServerAdapter).to be
  end

  it 'loads Helpers AbstractQuery module' do
    expect(described_class::Helpers::AbstractQuery).to be
  end

  it 'loads Helpers ColumnValue class' do
    expect(described_class::Helpers::ColumnValue).to be
  end
end
