require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Helpers::Timestamp do
  before :each do
    @adapter = MassInsert::Adapters::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "timestamp?" do
    context "when respond to timestamp columns" do
      it "should return true" do
        subject.stub(:column_names).and_return([:updated_at, :created_at])
        subject.timestamp?.should be_true
      end
    end

    context "when not respond to timestamp columns" do
      it "should return false" do
        subject.stub(:column_names).and_return(["created_at"])
        subject.timestamp?.should be_false
      end
    end
  end

  describe "timestamp_values" do
    it "should return the timestamp values in a hash" do
      timestamp_values = {
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
      }
      subject.timestamp_values.should eq(timestamp_values)
    end
  end
end
