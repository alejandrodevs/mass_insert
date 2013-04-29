require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Mysql2Adapter do
  let!(:subject){ MassInsert::Adapters::Mysql2Adapter.new([], {}) }

  it "should inherit from Adapter class" do
    expect(subject).to be_a(MassInsert::Adapters::Adapter)
  end

  describe "instance methods" do
    describe "#timestamp_format" do
      it "should respond to timestamp_format method" do
        expect(subject).to respond_to(:timestamp_format)
      end

      it "should return the format string" do
        expect(subject.timestamp_format).to eq("%Y-%m-%d %H:%M:%S")
      end
    end

    describe "#execute" do
      it "should respond to execute method" do
        expect(subject).to respond_to(:execute)
      end

      it "call methods and returns their values concatenated" do
        subject.stub(:begin_string).and_return("a")
        subject.stub(:string_columns).and_return("b")
        subject.stub(:string_values).and_return("c")
        expect(subject.execute).to eq("abc")
      end
    end
  end
end
