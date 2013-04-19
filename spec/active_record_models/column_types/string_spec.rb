require './spec/spec_helper'
require "./lib/mass_insert"

describe "String" do

  before :each do
    @values, @options  = [{:name => "some name"}], {}
  end

  context "when exist in values hashes" do
    context "when contains a string" do
      it "should be saved correctly" do
        User.mass_insert(@values, @options)
        User.last.name.should eq("some name")
      end
    end

    context "when contains a integer" do
      it "should convert integer value to string" do
        @values.first.merge!(:name => 10)
        User.mass_insert(@values, @options)
        User.last.name.should eq("10")
      end
    end

    context "when contains a decimal" do
      it "should convert decimal value to string" do
        @values.first.merge!(:name => 25.69)
        User.mass_insert(@values, @options)
        User.last.name.should eq("25.69")
      end
    end

    context "when contains a boolean" do
      it "should convert boolean value to string" do
        @values.first.merge!(:name => true)
        User.mass_insert(@values, @options)
        User.last.name.should eq("true")
      end
    end
  end

  context "when not exist in values hashes" do
    it "should save the default value" do
      @values.first.delete(:name)
      User.mass_insert(@values, @options)
      User.last.name.should eq(nil)
    end
  end
end
