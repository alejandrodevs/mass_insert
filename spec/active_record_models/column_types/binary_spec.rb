require './spec/spec_helper'
require "./lib/mass_insert"

describe "Binary" do

  before :each do
    @values, @options  = [{:checked => 1}], {}
  end

  context "when exist in values hashes" do
    context "when contains binary value" do
      context "when is 1" do
        it "should be saved correctly" do
          User.mass_insert(@values, @options)
          User.last.checked.should eq("1")
        end
      end

      context "when is 0" do
        it "should be saved correctly" do
          @values.first.merge!(:checked => 0)
          User.mass_insert(@values, @options)
          User.last.checked.should eq("0")
        end
      end
    end

    context "when contains a string" do
      it "should convert string value to binary" do
        @values.first.merge!(:checked => "string")
        User.mass_insert(@values, @options)
        User.last.checked.should eq("string")
      end
    end

    context "when contains a decimal" do
      it "should convert decimal value to binary" do
        @values.first.merge!(:checked => 25.34)
        User.mass_insert(@values, @options)
        User.last.checked.should eq("25.34")
      end
    end

    context "when contains a boolean" do
      it "should convert boolean value to binary" do
        @values.first.merge!(:checked => true)
        User.mass_insert(@values, @options)
        User.last.checked.should eq("true")
      end
    end
  end

  context "when not exist in values hashes" do
    it "should save the default value" do
      @values.first.delete(:checked)
      User.mass_insert(@values, @options)
      User.last.checked.should eq(nil)
    end
  end
end
