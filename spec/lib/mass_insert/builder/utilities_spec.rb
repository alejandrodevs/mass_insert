require 'spec_helper'

describe MassInsert::Builder::Utilities do
  describe "#adapter" do
    it "should respond to adapter method" do
      expect(described_class).to respond_to(:adapter)
    end

    it "should return the adapter type" do
      config = {"config" => {:adapter => "sql"}}
      connection = ActiveRecord::Base.connection
      connection.stub(:instance_values).and_return(config)
      expect(described_class.adapter).to eq("sql")
    end
  end
end
