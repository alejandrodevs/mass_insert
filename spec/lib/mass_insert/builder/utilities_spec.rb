require 'spec_helper'

describe MassInsert::Builder::Utilities do
  describe ".adapter" do
    it "returns adapter type" do
      connection = ActiveRecord::Base.connection
      connection.stub(:instance_values => {"config" => {:adapter => "mysql2"}})
      expect(described_class.adapter).to eq("mysql2")
    end
  end
end
