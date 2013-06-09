require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::AdapterHelpers::Sanitizer do
  let!(:subject){ MassInsert::Adapters::Adapter.new([], {}) }

  describe "#sanitized_columns" do
    before :each do
      options = {
        :primary_key      => :id,
        :primary_key_mode => :auto,
      }
      subject.options.merge!(options)
      subject.stub(:table_columns).and_return([:id, :name])
    end

    it "should respond to sanitized_columns" do
      expect(subject).to respond_to(:sanitized_columns)
    end

    context "when primary_key_mode is automatic" do
      it "should returns the column without primary_key" do
        expect(subject.sanitized_columns).to eq([:name])
      end
    end

    context "when primary_key_mode is not automatic" do
      it "should returns the columns including primary_key" do
        subject.options.merge!(:primary_key_mode => :manual)
        expect(subject.sanitized_columns).to eq([:id, :name])
      end
    end
  end

  describe "#table_columns" do
    it "should respond to table_columns method" do
      expect(subject).to respond_to(:table_columns)
    end

    it "should returns the table_columns in ActiveRecord class" do
      subject.options = {:class_name => Test}
      columns = [:id, :name, :email]
      expect(subject.table_columns).to eq(columns)
    end
  end
end
