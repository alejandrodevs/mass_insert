require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Helpers do
  it 'should be defined' do
    expect(MassInsert::Adapters::Helpers).to be
  end

  it 'should define AbstractQuery module' do
    expect(MassInsert::Adapters::Helpers::AbstractQuery).to be
  end

  it 'should define ColumnValue class' do
    expect(MassInsert::Adapters::Helpers::ColumnValue).to be
  end

  it 'should define Timestamp module' do
    expect(MassInsert::Adapters::Helpers::Timestamp).to be
  end

  it 'should define Sanitizer module' do
    expect(MassInsert::Adapters::Helpers::Sanitizer).to be
  end
end
