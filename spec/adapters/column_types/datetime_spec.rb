require 'spec_helper'

describe "Datetime" do
  let!(:values){ [{}] }
  let!(:options){ Hash.new }

  context "when contains datetime value" do
    it "saves the datetime value correctly" do
      values.first.merge!(created_at: DateTime.now)
      User.mass_insert(values, options)
      expect(User.last.created_at.strftime("%Y-%m-%d %H:%M")).to eq(DateTime.now.strftime("%Y-%m-%d %H:%M"))
    end
  end
end
