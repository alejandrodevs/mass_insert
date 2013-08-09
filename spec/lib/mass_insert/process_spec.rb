require 'spec_helper'

describe MassInsert::Process do
  let!(:subject){ MassInsert::Process.new([], {}) }

  describe "instance methods" do
    describe "#initialize" do
      let(:process){ MassInsert::Process.new("values", "options") }

      it "should initialize the values" do
        expect(process.values).to eq("values")
      end

      it "should initialize the options" do
        expect(process.options).to eq("options")
      end
    end

    describe "#start" do
      before :each do
        subject.stub(:build_query)
        subject.stub(:execute_query)
      end

      it "should respond to start method" do
        expect(subject).to respond_to(:start)
      end

      it "should call build_query" do
        subject.should_receive(:build_query).exactly(1).times
        subject.start
      end

      it "should define instance variable @build_time" do
        subject.start
        expect(subject.instance_variables).to include(:@build_time)
      end

      it "should call execute_query" do
        subject.should_receive(:execute_query).exactly(1).times
        subject.start
      end

      it "should define instance variable @execute_time" do
        subject.start
        expect(subject.instance_variables).to include(:@execute_time)
      end
    end

    describe "#execute_query" do
      before :each do
        @execution = MassInsert::Executer::Base.any_instance
        @execution.stub(:execute)
      end

      it "should respond to execute_query method" do
        expect(subject).to respond_to(:execute_query)
      end

      context "when query instance variable returns not nil" do
        it "should instance and call QueryExecution class" do
          subject.instance_variable_set(:@query, "query")
          @execution.should_receive(:execute).exactly(1).times
          subject.execute_query
        end
      end

      context "when query instance variable returns nil" do
        it "should instance and call QueryExecution class" do
          subject.instance_variable_set(:@query, nil)
          @execution.should_not_receive(:execute)
          subject.execute_query
        end
      end
    end

    describe "#build_query" do
      it "should respond to build_query method" do
        expect(subject).to respond_to(:build_query)
      end

      it "should instance and call QueryBuilder class" do
        MassInsert::Builder::Base.any_instance.stub(:build => "query")
        expect(subject.build_query).to eq("query")
      end

      it "should set query instance variable" do
        MassInsert::Builder::Base.any_instance.stub(:build)
        subject.build_query
        expect(subject.instance_variables).to include(:@query)
      end
    end
  end

  describe "#results" do
    before :each do
      a = Benchmark.measure{}
      a.stub(:total).and_return(10.0)
      subject.instance_variable_set(:@build_time, a)
      subject.instance_variable_set(:@execute_time, a)
    end

    it "should respond to results method" do
      expect(subject).to respond_to(:results)
    end

    it "should return total time in results" do
      expect(subject.results.time).to eql(20.0)
    end

    it "should return records persisted in results" do
      subject.stub(:values => [{}, {}])
      expect(subject.results.records).to eql(2)
    end

    it "should return build time in results" do
      expect(subject.results.build_time).to eql(10.0)
    end

    it "should return execute time in results" do
      expect(subject.results.execute_time).to eql(10.0)
    end
  end
end
