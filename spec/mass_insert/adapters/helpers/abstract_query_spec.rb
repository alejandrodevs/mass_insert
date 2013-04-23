require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Helpers::AbstractQuery do
  before :each do
    @adapter = MassInsert::Adapters::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "#begin_string" do
    it "should respond to begin_string method" do
      subject.respond_to?(:begin_string).should be_true
    end

    it "should returns the correct string" do
      subject.stub(:table_name).and_return("users")
      string = "INSERT INTO users "
      subject.begin_string.should eq(string)
    end
  end

  describe "#string_columns" do
    it "should respond to string_columns method" do
      subject.respond_to?(:string_columns).should be_true
    end

    it "should returns correct string to columns" do
      subject.stub(:column_names).and_return([:name, :email])
      subject.string_columns.should eq("(name, email) ")
    end
  end

  describe "#string_values" do
    it "should respond to string_values method" do
      subject.respond_to?(:string_values).should be_true
    end

    it "should returns correct string to values" do
      subject.stub(:string_rows_values).and_return("string_rows_values")
      subject.string_values.should eq("VALUES (string_rows_values);")
    end
  end

  describe "#string_rows_values" do
    it "should respond to string_rows_values method" do
      subject.respond_to?(:string_rows_values).should be_true
    end

    context "when only have one value hash" do
      it "should returns the correct string" do
        subject.stub(:string_single_row_values).and_return("single_row")
        subject.values = [{}]
        subject.string_rows_values.should eq("single_row")
      end
    end

    context "when have two or more value hashes" do
      it "should returns the correct string" do
        subject.stub(:string_single_row_values).and_return("single_row")
        subject.values = [{}, {}]
        subject.string_rows_values.should eq("single_row), (single_row")
      end
    end
  end

  describe "#string_single_row_values" do
    it "should respond to string_single_row_values method" do
      subject.respond_to?(:string_single_row_values).should be_true
    end

    it "should returns the correct string" do
      subject.stub(:string_single_value).and_return("single_value")
      subject.stub(:column_names).and_return([:name, :email])
      subject.string_single_row_values({}).should eq("single_value, single_value")
    end

    context "when respond to timestamp attributes" do
      it "should call timestamp_values method" do
        subject.stub(:string_single_value).and_return("single_value")
        subject.stub(:column_names).and_return([:created_at, :updated_at])
        subject.stub(:timestamp_values).and_return(:test => "test")
        subject.should_receive(:timestamp_values).exactly(1).times
        subject.string_single_row_values({})
      end
    end

    context "when not respond to timestamp attributes" do
      it "should returns the correct string" do
        subject.stub(:string_single_value).and_return("single_value")
        subject.stub(:column_names).and_return([:name, :email])
        subject.should_receive(:timestamp_values).exactly(0).times
        subject.string_single_row_values({})
      end
    end
  end

  describe "#string_single_value" do
    it "should respond to string_single_value method" do
      subject.respond_to?(:string_single_value).should be_true
    end

    it "should call build method in ColumnValue class" do
      column_value = MassInsert::Adapters::ColumnValue.any_instance
      column_value.stub(:build).and_return("single_value")
      subject.string_single_value({}, :name).should eq("single_value")
    end
  end
end
