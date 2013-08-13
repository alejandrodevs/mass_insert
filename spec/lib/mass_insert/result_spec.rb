require 'spec_helper'

describe MassInsert::Result do
  let!(:process){ MassInsert::Process.new([], {}) }
  let!(:subject){ MassInsert::Result.new(process) }

  before :each do
    benchmark = Benchmark.measure{}
    benchmark.stub(:total).and_return(10)
    process.instance_variable_set(:@building_time, benchmark)
    process.instance_variable_set(:@execution_time, benchmark)
    process.instance_variable_set(:@values, [{}, {}])
  end

  describe "initialize" do
    it "sets instance process variable" do
      expect(subject.instance_variable_get(:@process)).to eq(process)
    end
  end

  describe "#building_time" do
    it "returns instance building_time variable in process instance" do
      expect(subject.building_time).to be(10)
    end
  end

  describe "#execution_time" do
    it "returns instance execution_time variable in process instance" do
      expect(subject.execution_time).to be(10)
    end
  end

  describe "#time" do
    it "sums building_time and execution_time" do
      expect(subject.time).to be(20)
    end
  end

  describe "#records" do
    it "returns size of instance values variable in process instance" do
      expect(subject.records).to be(2)
    end
  end
end
