require 'spec_helper'

describe MassInsert::Builder::Adapters::Helpers::AbstractQuery do
  let!(:subject){ MassInsert::Builder::Adapters::Adapter.new([], {}) }

  describe "#begin_string" do
    it "returns the basic beginning of the query" do
      subject.stub(:class_name).and_return(User)
      expect(subject.begin_string).to eq("INSERT INTO users ")
    end
  end

  describe "#string_columns" do
    it "returns the correct columns string" do
      subject.stub(:columns).and_return([:name, :email])
      expect(subject.string_columns).to eq("(name, email) ")
    end
  end

  describe "#string_values" do
    it "returns the correct values string" do
      subject.stub(:string_rows_values).and_return("rows_values")
      expect(subject.string_values).to eq("VALUES (rows_values);")
    end
  end

  describe "#string_rows_values" do
    context "when is one value" do
      it "returns the correct string" do
        subject.stub(:string_single_row_values).and_return("row")
        subject.values = [{}]
        expect(subject.string_rows_values).to eq("row")
      end
    end

    context "when are two or more values" do
      it "returns the correct string" do
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

    it "returns the correct string" do
      subject.stub(:columns).and_return([:name, :email])
      expect(subject.string_single_row_values({})).to eq("value, value")
    end

    context "when responds to timestamp attributes" do
      it "calls timestamp_values method" do
        subject.stub(:columns).and_return([:created_at, :updated_at])
        subject.stub(:timestamp_hash).and_return(:test => "test")
        subject.should_receive(:timestamp_hash).exactly(1).times
        subject.string_single_row_values({})
      end
    end

    context "when not respond to timestamp attributes" do
      it "should returns the correct string" do
        subject.stub(:columns).and_return([:name, :email])
        subject.should_receive(:timestamp_hash).exactly(0).times
        subject.string_single_row_values({})
      end
    end
  end

  describe "#string_single_value" do
    let(:row){ Hash.new }
    let(:column){ :name }
    let(:column_value_class){ MassInsert::Builder::Adapters::Helpers::ColumnValue }

    before :each do
      subject.stub(:class_name).and_return(User)
    end

    it "instances ColumnValue class exactly one time" do
      column_value_class.stub(:new).and_return("column_value_instance")
      column_value_class.new.stub(:build).and_return("column_value")
      column_value_class.should_receive(:new).exactly(1).times
      subject.string_single_value(row, column)
    end

    it "instances ColumnValue class with the correct params" do
      column_value_class.stub(:new).and_return("column_value_instance")
      column_value_class.new.stub(:build).and_return("column_value")
      column_value_class.should_receive(:new).with(row, column, User)
      subject.string_single_value(row, column)
    end

    it "calls ColumnValue#build exactly one time" do
      column_value_class.any_instance.should_receive(:build).exactly(1).times
      subject.string_single_value(row, column)
    end

    it "returns ColumnValue#build method result" do
      column_value_class.any_instance.stub(:build).and_return("column_value1")
      expect(subject.string_single_value(row, column)).to eq("column_value1")
    end
  end

  describe "#execute" do
    before :each do
      subject.stub(:begin_string).and_return("a")
      subject.stub(:string_columns).and_return("b")
      subject.stub(:string_values).and_return("c")
    end

    context "when have less or equal values than values_per_insertion" do
      it "generates one query" do
        subject.values = [{}]
        subject.stub(:values_per_insertion).and_return(1)
        expect(subject.execute).to eq(["abc"])
      end
    end

    context "when have more values than values_per_insertion" do
      it "generates queries according to the slices" do
        subject.values = [{}, {}]
        subject.stub(:values_per_insertion).and_return(1)
        expect(subject.execute).to eq(["abc", "abc"])
      end
    end
  end
end
