require 'spec_helper'

describe "String" do
  let!(:values){ [{}] }
  let!(:options){ Hash.new }

  context "when contains a string" do
    it "saves the value correctly" do
      values.first.merge!(name: "name")
      User.mass_insert(values, options)
      expect(User.last.name).to eq("name")
    end
  end

  context "when contains a integer" do
    it "converts integer value to string" do
      values.first.merge!(name: 10)
      User.mass_insert(values, options)
      expect(User.last.name).to eq("10")
    end
  end

  context "when contains a decimal" do
    it "converts decimal value to string" do
      values.first.merge!(name: 25.69)
      User.mass_insert(values, options)
      expect(User.last.name).to eq("25.69")
    end
  end

  context "when contains a boolean" do
    it "converts boolean value to string" do
      values.first.merge!(name: true)
      User.mass_insert(values, options)
      expect(User.last.name).to eq("true")
    end
  end

  context "when not exist in values hashes" do
    it "saves the default value" do
      values.first.delete(:name)
      User.mass_insert(values, options)
      expect(User.last.name).to eq(nil)
    end
  end
end
