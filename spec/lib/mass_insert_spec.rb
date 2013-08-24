require 'spec_helper'

describe MassInsert do
  it 'should be defined' do
    expect(MassInsert).to be
  end

  it 'should define Base' do
    expect(MassInsert::Base).to be
  end

  it 'should define Result class' do
    expect(MassInsert::Result).to be
  end

  it 'should define Process class' do
    expect(MassInsert::Process).to be
  end

  it 'should define Executer class' do
    expect(MassInsert::Executer).to be
  end

  it 'should define Adapters in Builder module' do
    expect(MassInsert::Builder::Adapters).to be
  end

  it 'should define Utilities in Builder module' do
    expect(MassInsert::Builder::Utilities).to be
  end

  it 'should define Base in Builder module' do
    expect(MassInsert::Builder::Base).to be
  end
end
