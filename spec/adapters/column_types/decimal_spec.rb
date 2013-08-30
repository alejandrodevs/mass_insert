require 'spec_helper'

describe "Decimal" do
  let!(:values){ [{}] }
  let!(:options){ Hash.new }

  context "when contains an integer" do
    it "converts integer value to decimal" do
      values.first.merge!(money: 10)
      User.mass_insert(values, options)
      expect(User.last.money).to eq(10.0)
    end
  end

  context "when contains a string without digits" do
    it "converts string value to decimal" do
      values.first.merge!(money: "string")
      User.mass_insert(values, options)
      expect(User.last.money).to eq(0.0)
    end
  end

  context "when contains a digits string" do
    it "converts string value to decimal" do
      values.first.merge!(money: "100")
      User.mass_insert(values, options)
      expect(User.last.money).to eq(100.0)
    end

    it "converts string value to decimal" do
      values.first.merge!(money: "200.50")
      User.mass_insert(values, options)
      expect(User.last.money).to eq(200.50)
    end
  end

  context "when contains a decimal" do
    it "saves the correct value" do
      values.first.merge!(money: 20.50)
      User.mass_insert(values, options)
      expect(User.last.money).to eq(20.50)
    end
  end

  context "when contains a boolean" do
    it "raises an exception" do
      values.first.merge!(money: true)
      expect(lambda{ User.mass_insert(values, options) }).to raise_exception
    end
  end

  context "when not exist in values hashes" do
    it "saves the default value" do
      values.first.delete(:money)
      User.mass_insert(values, options)
      expect(User.last.money).to eq(nil)
    end
  end
end
