require 'spec_helper'

describe "Time" do
  let!(:values){ [{}] }
  let!(:options){ Hash.new }

  context "when contains time value" do
    it "saves the time value correctly" do
      values.first.merge!(birthtime: Time.now)
      User.mass_insert(values, options)
      expect(User.last.birthtime.strftime("%H:%M")).to eq(Time.now.strftime("%H:%M"))
    end
  end
end
