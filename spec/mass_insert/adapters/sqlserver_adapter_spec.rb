require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::SQLServerAdapter do
  let!(:subject){ MassInsert::Adapters::SQLServerAdapter.new([], {}) }

  it "should inherit from Adapter class" do
    expect(subject).to be_a(MassInsert::Adapters::Adapter)
  end

  describe "instance methods" do
    describe "#execute" do
      before :each do
        subject.stub(:begin_string).and_return("a")
        subject.stub(:string_columns).and_return("b")
        subject.stub(:string_values).and_return("c")
      end

      it "should respond to execute method" do
        expect(subject).to respond_to(:execute)
      end

      context "when have less than 1000 values" do
        it "call methods and returns their values concatenated" do
          subject.values = [{}]
          expect(subject.execute).to eq(["abc"])
        end
      end

      context "when have more than 1000 values" do
        it "call methods and returns their values concatenated" do
          1500.times{ subject.values << {} }
          expect(subject.execute).to eq(["abc", "abc"])
        end
      end
    end
  end

  describe "MAX_VALUES_PER_INSERTION" do
    let(:class_name){ MassInsert::Adapters::SQLServerAdapter }

    it "should respond_to" do
      constant   = :MAX_VALUES_PER_INSERTION
      expect(class_name.const_defined?(constant)).to be_true
    end

    it "should return 1000" do
      expect(class_name::MAX_VALUES_PER_INSERTION).to eq(1000)
    end
  end
end
