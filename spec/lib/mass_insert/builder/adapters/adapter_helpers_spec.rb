require 'spec_helper'

describe MassInsert::Builder::Adapters::AdapterHelpers do
  it 'should be defined' do
    expect(MassInsert::Builder::Adapters::AdapterHelpers).to be
  end

  it 'should define AbstractQuery module' do
    expect(MassInsert::Builder::Adapters::AdapterHelpers::AbstractQuery).to be
  end

  it 'should define ColumnValue class' do
    expect(MassInsert::Builder::Adapters::AdapterHelpers::ColumnValue).to be
  end

  it 'should define Timestamp module' do
    expect(MassInsert::Builder::Adapters::AdapterHelpers::Timestamp).to be
  end

  it 'should define Sanitizer module' do
    expect(MassInsert::Builder::Adapters::AdapterHelpers::Sanitizer).to be
  end
end
