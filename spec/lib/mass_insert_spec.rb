require 'spec_helper'

describe MassInsert do
  it 'loads Base module' do
    expect(described_class::Base).to be
  end

  it 'loads Result class' do
    expect(described_class::Result).to be
  end

  it 'loads Process class' do
    expect(described_class::Process).to be
  end

  it 'loads Executer class' do
    expect(described_class::Executer).to be
  end

  it 'loads VERSION constant' do
    expect(described_class::VERSION).to be
  end

  it 'loads Builder Base module' do
    expect(described_class::Builder::Base).to be
  end

  it 'loads Builder Adapters module' do
    expect(described_class::Builder::Adapters).to be
  end

  it 'loads Builder Utilities module' do
    expect(described_class::Builder::Utilities).to be
  end
end
