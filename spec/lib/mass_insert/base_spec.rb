require 'spec_helper'

describe MassInsert::Base do
  let!(:values) { [{name: "name"}] }
  let!(:options){ {option: "value"} }

  before :each do
    MassInsert::Process.any_instance.stub(:start)
  end

  describe ".mass_insert" do
    it "can receive values and options" do
      expect{ User.mass_insert(values, options) }.to_not raise_error
    end

    it "can receive only values" do
      expect{ User.mass_insert(values) }.to_not raise_error
    end

    it "can't call without params" do
      expect{ User.mass_insert }.to raise_error
    end
  end

  describe ".mass_insert_results" do
    before :each do
      User.mass_insert(values, options)
    end

    it "returns a MassInsert::Result instance" do
      expect(User.mass_insert_results).to be_an_instance_of(MassInsert::Result)
    end

    it "calls MassInsert::Result.new with mass_insert process" do
      process = User.instance_variable_get(:@mass_insert_process)
      MassInsert::Result.should_receive(:new).with(process).exactly(1).times
      User.mass_insert_results
    end
  end
end
