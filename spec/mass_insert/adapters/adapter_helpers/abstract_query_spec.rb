require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::AdapterHelpers::AbstractQuery do
  let!(:options){ {:class_name => "SomeClassName"} }
  let!(:subject){ MassInsert::Adapters::Adapter.new([], options) }

  describe "#begin_string" do
    it "should respond to begin_string method" do
      expect(subject).to respond_to(:begin_string)
    end

    it "should returns the correct string" do
      subject.stub(:table_name).and_return("users")
      expect(subject.begin_string).to eq("INSERT INTO users ")
    end
  end

  describe "#string_columns" do
    it "should respond to string_columns method" do
      expect(subject).to respond_to(:string_columns)
    end

    it "should returns correct string to columns" do
      subject.stub(:columns).and_return([:name, :email])
      expect(subject.string_columns).to eq("(name, email) ")
    end
  end

  describe "#string_values" do
    it "should respond to string_values method" do
      expect(subject).to respond_to(:string_values)
    end

    it "should returns correct string to values" do
      subject.stub(:string_rows_values).and_return("rows_values")
      expect(subject.string_values).to eq("VALUES (rows_values);")
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
        expect(subject.string_rows_values).to eq("row), (row")
      end
    end
  end

  describe "#string_single_row_values" do
    before :each do
      subject.stub(:string_single_value).and_return("value")
    end

    it "should respond to string_single_row_values method" do
      expect(subject).to respond_to(:string_single_row_values)
    end

    it "should returns the correct string" do
      subject.stub(:columns).and_return([:name, :email])
      expect(subject.string_single_row_values({})).to eq("value, value")
    end

    context "when respond to timestamp attributes" do
      it "should call timestamp_values method" do
        subject.stub(:columns).and_return([:created_at, :updated_at])
        subject.stub(:timestamp_values).and_return(:test => "test")
        subject.should_receive(:timestamp_values).exactly(1).times
        subject.string_single_row_values({})
      end
    end

    context "when not respond to timestamp attributes" do
      it "should returns the correct string" do
        subject.stub(:columns).and_return([:name, :email])
        subject.should_receive(:timestamp_values).exactly(0).times
        subject.string_single_row_values({})
      end
    end
  end

  describe "#string_single_value" do
    it "should respond to string_single_value method" do
      expect(subject).to respond_to(:string_single_value)
    end

    it "should call build method in ColumnValue class" do
      column_value = MassInsert::Adapters::AdapterHelpers::ColumnValue.any_instance
      column_value.stub(:build).and_return("value")
      expect(subject.string_single_value({}, :name)).to eq("value")
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
