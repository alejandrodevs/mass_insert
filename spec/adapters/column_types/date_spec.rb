require 'spec_helper'

describe "Date" do
  let!(:values){ [{}] }
  let!(:options){ Hash.new }

  context "when contains date value" do
    it "saves the date value correctly" do
      values.first.merge!(birthday: Date.today)
      User.mass_insert(values, options)
      expect(User.last.birthday).to eq(Date.today)
    end
  end
end
