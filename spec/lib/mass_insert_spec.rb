require 'spec_helper'

describe MassInsert do
  it 'loads Base module' do
    expect(MassInsert::Base).to be
  end

  it 'loads Result class' do
    expect(MassInsert::Result).to be
  end

  it 'loads Process class' do
    expect(MassInsert::Process).to be
  end

  it 'loads Executer class' do
    expect(MassInsert::Executer).to be
  end

  it 'loads VERSION constant' do
    expect(MassInsert::VERSION).to be
  end

  it 'loads Builder Base module' do
    expect(MassInsert::Builder::Base).to be
  end

  it 'loads Builder Adapters module' do
    expect(MassInsert::Builder::Adapters).to be
  end

  it 'loads Builder Utilities module' do
    expect(MassInsert::Builder::Utilities).to be
  end
end
