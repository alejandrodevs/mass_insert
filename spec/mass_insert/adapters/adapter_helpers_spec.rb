require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::AdapterHelpers do
  it 'should be defined' do
    expect(MassInsert::Adapters::AdapterHelpers).to be
  end

  it 'should define AbstractQuery module' do
    expect(MassInsert::Adapters::AdapterHelpers::AbstractQuery).to be
  end

  it 'should define ColumnValue class' do
    expect(MassInsert::Adapters::AdapterHelpers::ColumnValue).to be
  end

  it 'should define Timestamp module' do
    expect(MassInsert::Adapters::AdapterHelpers::Timestamp).to be
  end

  it 'should define Sanitizer module' do
    expect(MassInsert::Adapters::AdapterHelpers::Sanitizer).to be
  end
end
