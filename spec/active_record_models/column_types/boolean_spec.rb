require './spec/spec_helper'
require "./lib/mass_insert"

describe "Boolean" do

  before :each do
    @values, @options  = [{:active => true}], {}
  end

  context "when exist in values hashes" do
    context "when contains boolean value" do
      context "when is true" do
        it "should be saved correctly" do
          User.mass_insert(@values, @options)
          User.last.active.should eq(true)
        end
      end

      context "when is false" do
        it "should be saved correctly" do
          @values.first.merge!(:active => false)
          User.mass_insert(@values, @options)
          User.last.active.should eq(false)
        end
      end
    end

    context "when contains a string" do
      it "should convert string value to boolean" do
        @values.first.merge!(:active => "string")
        User.mass_insert(@values, @options)
        User.last.active.should eq(true)
      end
    end

    context "when contains a decimal" do
      it "should convert decimal value to boolean" do
        @values.first.merge!(:active => 25.34)
        User.mass_insert(@values, @options)
        User.last.active.should eq(true)
      end
    end
  end

  context "when not exist in values hashes" do
    it "should save the default value" do
      @values.first.delete(:active)
      User.mass_insert(@values, @options)
      User.last.active.should eq(nil)
    end
  end
end
