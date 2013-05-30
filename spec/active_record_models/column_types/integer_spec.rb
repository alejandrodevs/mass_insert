require './spec/spec_helper'
require "./lib/mass_insert"

describe "Integer" do

  before :each do
    @values, @options  = [{:age => 20}], {}
  end

  context "when exist in values hashes" do
    context "when contains an integer" do
      it "should be saved correctly" do
        User.mass_insert(@values, @options)
        expect(User.last.age).to eq(20)
      end
    end

    context "when contains a string" do
      it "should convert string value to integer" do
        @values.first.merge!(:age => "string")
        User.mass_insert(@values, @options)
        expect(User.last.age).to eq(0)
      end
    end

    context "when contains a decimal" do
      it "should convert decimal value to integer" do
        @values.first.merge!(:age => 25.69)
        User.mass_insert(@values, @options)
        expect(User.last.age).to eq(25)
      end
    end

    context "when contains a boolean" do
      it "should raise an exception" do
        @values.first.merge!(:age => true)
        expect(lambda{ User.mass_insert(@values, @options) }).to raise_exception
      end
    end
  end

  context "when not exist in values hashes" do
    it "should save the default value" do
      @values.first.delete(:age)
      User.mass_insert(@values, @options)
      expect(User.last.age).to eq(nil)
    end
  end
end
