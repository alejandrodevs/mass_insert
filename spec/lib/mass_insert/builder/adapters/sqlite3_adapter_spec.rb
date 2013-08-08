require 'spec_helper'

describe MassInsert::Builder::Adapters::SQLite3Adapter do
  let!(:subject){ MassInsert::Builder::Adapters::SQLite3Adapter.new([], {}) }

  it "should inherit from Adapter class" do
    expect(subject).to be_a(MassInsert::Builder::Adapters::Adapter)
  end

  describe "instance methods" do
    describe "#string_values" do
      it "should respond to string_values method" do
        expect(subject).to respond_to(:string_values)
      end

      it "should returns correct string to values" do
        subject.stub(:string_rows_values).and_return("rows_values")
        expect(subject.string_values).to eq("SELECT rows_values;")
      end
    end

    describe "#string_rows_values" do
      it "should respond to string_rows_values method" do
        expect(subject).to respond_to(:string_rows_values)
      end

      context "when only have one value hash" do
        it "should returns the correct string" do
          subject.stub(:string_single_row_values).and_return("row")
          subject.values = [{}]
          expect(subject.string_rows_values).to eq("row")
        end
      end

      context "when have two or more value hashes" do
        it "should returns the correct string" do
          subject.stub(:string_single_row_values).and_return("row")
          subject.values = [{}, {}]
          expect(subject.string_rows_values).to eq("row UNION SELECT row")
        end
      end
    end

    describe "#execute" do
      before :each do
        subject.stub(:begin_string).and_return("a")
        subject.stub(:string_columns).and_return("b")
        subject.stub(:string_values).and_return("c")
      end

      it "should respond to execute method" do
        expect(subject).to respond_to(:execute)
      end

      context "when have less than 500 values" do
        it "call methods and returns their values concatenated" do
          subject.values = [{}]
          expect(subject.execute).to eq(["abc"])
        end
      end

      context "when have more than 500 values" do
        it "call methods and returns their values concatenated" do
          800.times{ subject.values << {} }
          expect(subject.execute).to eq(["abc", "abc"])
        end
      end
    end
  end

  describe "MAX_VALUES_PER_INSERTION" do
    let(:class_name){ MassInsert::Builder::Adapters::SQLite3Adapter }

    it "should respond_to" do
      constant   = :MAX_VALUES_PER_INSERTION
      expect(class_name.const_defined?(constant)).to be_true
    end

    it "should return 1000" do
      expect(class_name::MAX_VALUES_PER_INSERTION).to eq(500)
    end
  end
end
