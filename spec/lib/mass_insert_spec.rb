require 'spec_helper'

describe MassInsert do
  it 'should be defined' do
    expect(MassInsert).to be
  end

  it 'should define Adapters in Builder module' do
    expect(MassInsert::Builder::Adapters).to be
  end

  it 'should define Base in Builder module' do
    expect(MassInsert::Builder::Base).to be
  end

  it 'should define Base' do
    expect(MassInsert::Base).to be
  end

  it 'should define ProcessControl' do
    expect(MassInsert::ProcessControl).to be
  end

  it 'should define QueryExecution' do
    expect(MassInsert::QueryExecution).to be
  end
end
