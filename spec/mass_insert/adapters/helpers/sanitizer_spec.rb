require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Helpers::Sanitizer do

  before :each do
    @adapter = MassInsert::Adapters::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "sanitized_columns" do
    before :each do
      options = {
        :primary_key      => :id,
        :primary_key_mode => :auto,
      }
      subject.options.merge!(options)
      subject.stub(:table_columns).and_return([:id, :name])
    end

    it "should respond to sanitized_columns" do
      subject.respond_to?(:sanitized_columns).should be_true
    end

    context "when primary_key_mode is automatic" do
      it "should returns the column without primary_key" do
        subject.sanitized_columns.should eq([:name])
      end
    end

    context "when primary_key_mode is not automatic" do
      it "should returns the columns including primary_key" do
        subject.options.merge!(:primary_key_mode => :manual)
        subject.sanitized_columns.should eq([:id, :name])
      end
    end
  end
end
