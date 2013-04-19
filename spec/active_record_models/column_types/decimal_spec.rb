require './spec/spec_helper'
require "./lib/mass_insert"

describe "Decimal" do

  before :each do
    @values, @options  = [{:money => 20.50}], {}
  end

  context "when exist in values hashes" do
    context "when contains an integer" do
      it "should convert integer value to decimal" do
        @values.first.merge!(:money => 10)
        User.mass_insert(@values, @options)
        User.last.money.should eq(10.0)
      end
    end

    context "when contains a string" do
      it "should convert string value to decimal" do
        @values.first.merge!(:money => "string")
        User.mass_insert(@values, @options)
        User.last.money.should eq(0.0)
      end
    end

    context "when contains a decimal" do
      it "should save the correct value" do
        User.mass_insert(@values, @options)
        User.last.money.should eq(20.50)
      end
    end

    context "when contains a boolean" do
      it "should raise an exception" do
        @values.first.merge!(:money => true)
        lambda{ User.mass_insert(@values, @options) }.should raise_exception
      end
    end
  end

  context "when not exist in values hashes" do
    it "should save the default value" do
      @values.first.delete(:money)
      User.mass_insert(@values, @options)
      User.last.money.should eq(nil)
    end
  end
end
