require 'spec_helper'

describe "Binary" do
  let!(:values){ [{}] }
  let!(:options){ Hash.new }

  context "when contains binary value" do
    context "when is 1" do
      it "saves the value correctly" do
        values.first.merge!(checked: 1)
        User.mass_insert(values, options)
        expect(User.last.checked).to eq("1")
      end
    end

    context "when is 0" do
      it "saves the value correctly" do
        values.first.merge!(checked: 0)
        User.mass_insert(values, options)
        expect(User.last.checked).to eq("0")
      end
    end
  end

  context "when contains a string" do
    it "converts string value to binary" do
      values.first.merge!(checked: "string")
      User.mass_insert(values, options)
      expect(User.last.checked).to eq("string")
    end
  end

  context "when contains a integer greater than 1" do
    it "converts integer value to binary" do
      values.first.merge!(checked: 150)
      User.mass_insert(values, options)
      expect(User.last.checked).to eq("150")
    end
  end

  context "when contains a decimal" do
    it "converts decimal value to binary" do
      values.first.merge!(checked: 25.34)
      User.mass_insert(values, options)
      expect(User.last.checked).to eq("25.34")
    end
  end

  context "when contains a boolean" do
    it "converts boolean value to binary" do
      values.first.merge!(checked: true)
      User.mass_insert(values, options)
      expect(User.last.checked).to eq("true")
    end
  end

  context "when not exist in values hashes" do
    it "saves the default value" do
      values.first.delete(:checked)
      User.mass_insert(values, options)
      expect(User.last.checked).to eq(nil)
    end
  end
end
