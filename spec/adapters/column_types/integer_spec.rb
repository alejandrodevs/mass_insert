require 'spec_helper'

describe "Integer" do
  let!(:values){ [{}] }
  let!(:options){ Hash.new }

  context "when contains an integer" do
    it "saves the value correctly" do
      values.first.merge!(age: 20)
      User.mass_insert(values, options)
      expect(User.last.age).to eq(20)
    end
  end

  context "when contains a string without digits" do
    it "converts string value to integer" do
      values.first.merge!(age: "string")
      User.mass_insert(values, options)
      expect(User.last.age).to eq(0)
    end
  end

  context "when contains a digits string" do
    it "converts string value to integer" do
      values.first.merge!(age: "100")
      User.mass_insert(values, options)
      expect(User.last.age).to eq(100)
    end

    it "converts string value to integer" do
      values.first.merge!(age: "200.45")
      User.mass_insert(values, options)
      expect(User.last.age).to eq(200)
    end
  end

  context "when contains a decimal" do
    it "converts decimal value to integer" do
      values.first.merge!(age: 25.69)
      User.mass_insert(values, options)
      expect(User.last.age).to eq(25)
    end
  end

  context "when contains a boolean" do
    it "raises an exception" do
      values.first.merge!(age: true)
      expect(lambda{ User.mass_insert(values, options) }).to raise_exception
    end
  end

  context "when not exist in values hashes" do
    it "saves the default value" do
      values.first.delete(:age)
      User.mass_insert(values, options)
      expect(User.last.age).to eq(nil)
    end
  end
end
