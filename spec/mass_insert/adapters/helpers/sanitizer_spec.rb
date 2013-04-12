require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Helpers::Sanitizer do
  before :each do
    @adapter = MassInsert::Adapters::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "sanitize_columns" do
    it "should respond to sanitize_columns" do
      subject.respond_to?(:sanitize_columns).should be_true
    end

    it "should call sanitize_primary_key_column method" do
      subject.should_receive(:sanitize_primary_key_column)
      subject.sanitize_columns
    end
  end

  describe "sanitize_primary_key_column" do
    before :each do
      subject.options = {
        :primary_key      => :id,
        :primary_key_mode => :auto,
      }
      subject.stub(:column_names).and_return([:id, :name])
    end

    it "should respond to sanitize_primary_key_column" do
      subject.respond_to?(:sanitize_primary_key_column).should be_true
    end

    context "when primary_key_mode is automatic" do
      it "should returns the column names without primary_key" do
        subject.sanitize_primary_key_column
        subject.column_names.should eq([:name])
      end
    end

    context "when primary_key_mode is not automatic" do
      it "should returns the column names with primary_key" do
        subject.options.merge!(:primary_key_mode => "manually")
        subject.sanitize_primary_key_column
        subject.column_names.should eq([:id, :name])
      end
    end
  end
end
