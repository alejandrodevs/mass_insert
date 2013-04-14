require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Base do
  describe "class methods" do
    describe ".mass_insert" do
      it "should respond to mass_insert class method" do
        User.respond_to?(:mass_insert).should be_true
      end

      it "should can receive values and many options" do
        values  = [{:name => "name"}]
        options = {:option_one => "one", :option_two => "two"}
        User.mass_insert(values, options).should be_true
      end

      it "should can receive only values" do
        values  = [{:name => "name"}]
        User.mass_insert(values).should be_true
      end

      it "should not can called with values" do
        lambda{ User.mass_insert }.should raise_error
      end
    end

    describe "sanitize options" do
      describe "class_name" do
        it "returns class name that call if options doesn't exist" do
          pending
        end

        it "returns class_name option if is in the options" do
          pending
        end
      end

      describe "table_name" do
        it "returns class table_name that call if options doesn't exist" do
          pending
        end

        it "returns table_name option if is in the options" do
          pending
        end
      end

      describe "primary_key" do
        it "returns :id if option primary_key doesn't exist" do
          pending
        end

        it "returns primary_key option if is in the options" do
          pending
        end
      end

      describe "primary_key_mode" do
        it "returns :auto if option primary_key_mode doesn't exist" do
          pending
        end

        it "returns primary_key_mode option if is in the options" do
          pending
        end
      end
    end
  end
end
