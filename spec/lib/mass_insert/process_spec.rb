require 'spec_helper'

module MassInsert
  describe Process do
    let!(:subject){ described_class.new("values", "options") }

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
        Builder::Base.any_instance.stub(:build).and_return("queries")
        Executer.any_instance.stub(:execute)
      end

      it "calls method to build the queries" do
        Builder::Base.any_instance.should_receive(:build).with("values", "options")
        subject.start
      end

      it "calls method to execute the queries" do
        Executer.any_instance.should_receive(:execute).with("queries")
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

    describe '#builder' do
      it 'returns new Builder::Base instace' do
        expect(subject.builder).to be_an_instance_of(Builder::Base)
      end
    end

    describe '#executer' do
      it 'returns new Executer instace' do
        expect(subject.executer).to be_an_instance_of(Executer)
      end
    end
  end
end
