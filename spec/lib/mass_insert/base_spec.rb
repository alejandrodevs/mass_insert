require 'spec_helper'

describe MassInsert::Base do
  let!(:values) { [{name: "name"}] }
  let!(:options){ {:option_one => "one", :option_two => "two"} }

  before :each do
    MassInsert::Process.any_instance.stub(:start)
  end

  describe ".mass_insert" do
    it "can receive values and options" do
      expect(lambda{ User.mass_insert(values, options) }).to_not raise_error
    end

    it "can receive only values" do
      expect(lambda{ User.mass_insert(values) }).to_not raise_error
    end

    it "should not can called with values" do
      expect(lambda{ User.mass_insert }).to raise_error
    end

    it "should call execute ProcessControl method" do
      MassInsert::Process.any_instance.should_receive(:start)
      Test.mass_insert(values, options)
    end
  end

  describe ".mass_insert_results" do
    before :each do
      User.mass_insert(values, options)
    end

    it "returns a MassInsert::Result instance" do
      expect(User.mass_insert_results).to be_an_instance_of(MassInsert::Result)
    end

    it "calls new MassInsert::Result method with the process" do
      process = User.instance_variable_get(:@mass_insert_process)
      MassInsert::Result.should_receive(:new).with(process)
      User.mass_insert_results
    end
  end
end
