require 'spec_helper'

describe "Boolean" do
  let!(:values){ [{}] }
  let!(:options){ Hash.new }

  context "when contains boolean value" do
    context "when is true" do
      it "saves the true value correctly" do
        values.first.merge!(active: true)
        User.mass_insert(values, options)
        expect(User.last.active).to eq(true)
      end
    end

    context "when is false" do
      it "saves the false value correctly" do
        values.first.merge!(active: false)
        User.mass_insert(values, options)
        expect(User.last.active).to eq(false)
      end
    end
  end

  context "when contains a string" do
    it "converts string value to boolean" do
      values.first.merge!(active: "string")
      User.mass_insert(values, options)
      expect(User.last.active).to eq(true)
    end
  end

  context "when contains a decimal" do
    it "converts decimal value to boolean" do
      values.first.merge!(active: 25.34)
      User.mass_insert(values, options)
      expect(User.last.active).to eq(true)
    end
  end

  context "when not exist in values hashes" do
    it "saves the default value" do
      values.first.delete(:active)
      User.mass_insert(values, options)
      expect(User.last.active).to eq(nil)
    end
  end
end
