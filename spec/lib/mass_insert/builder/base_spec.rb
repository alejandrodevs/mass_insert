require 'spec_helper'

describe MassInsert::Builder::Base do
  describe "#build" do
    adapters_supported.each do |adapter_type, adapter_class|
      context "when adapter_class is #{adapter_class}" do
        it "returns the queries" do
          adapter = "MassInsert::Builder::Adapters::#{adapter_class}".constantize
          adapter.any_instance.stub(:execute).and_return("#{adapter_type}_queries")
          subject.stub(:adapter_class).and_return(adapter)
          expect(subject.build("values", "options")).to eq("#{adapter_type}_queries")
        end
      end
    end
  end

  describe "#adapter_class" do
    adapters_supported.each do |adapter_type, adapter_class|
      context "when adapter is #{adapter_type}" do
        it "returns #{adapter_class}" do
          MassInsert::Builder::Utilities.stub(:adapter).and_return(adapter_type)
          adapter = "MassInsert::Builder::Adapters::#{adapter_class}".constantize
          expect(subject.adapter_class).to eq(adapter)
        end
      end
    end
  end
end
