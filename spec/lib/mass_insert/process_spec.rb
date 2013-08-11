require 'spec_helper'

describe MassInsert::Process do
  let!(:subject){ MassInsert::Process.new("values", "options") }

  describe "#initialize" do
    it "sets instance values variable" do
      expect(subject.instance_variable_get(:@values)).to eq("values")
    end

    it "sets instance options variable" do
      expect(subject.instance_variable_get(:@options)).to eq("options")
    end
  end

  describe "#start" do
    before :each do
      MassInsert::Builder::Base.any_instance.stub(:build).and_return("queries")
      MassInsert::Executer.any_instance.stub(:execute)
    end

    it "calls method to build the queries" do
      MassInsert::Builder::Base.any_instance.should_receive(:build).with("values", "options")
      subject.start
    end

    it "calls method to execute the queries" do
      MassInsert::Executer.any_instance.should_receive(:execute).with("queries")
      subject.start
    end

    it "sets instance building_time variable" do
      subject.start
      building_time = subject.instance_variable_get(:@building_time)
      expect(building_time).to be_an_instance_of(Benchmark::Tms)
    end

    it "sets instance execution_time variable" do
      subject.start
      execution_time = subject.instance_variable_get(:@execution_time)
      expect(execution_time).to be_an_instance_of(Benchmark::Tms)
    end
  end
end
