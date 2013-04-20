require './spec/spec_helper'
require "./lib/mass_insert"
require "./spec/dummy_models/test"

describe "Model" do

  before :each do
    @values, @options  = [], {}
    @value_hash = {
      :name    => "some_name",
      :email   => "some_email",
      :age     => 20,
      :active  => true,
      :checked => true
    }
    User.delete_all
  end

  context "when is used without options" do
    it "should save 5 record into users table" do
      5.times{ @values << @value_hash }
      User.mass_insert(@values, @options)
      User.count.should eq(5)
    end

    it "should save if values cointains 1200 records" do
      1200.times{ @values << @value_hash }
      User.mass_insert(@values, @options)
      User.count.should eq(1200)
    end
  end

  context "when is used with options" do
    context "when the table name doesn't exit" do
      it "should not save any record" do
        5.times{ @values << @value_hash }
        @options.merge!(:table_name => "countries")
        lambda{ User.mass_insert(@values, @options) }.should raise_exception
      end
    end

    context "when the class name not inherit from ActiveRecord" do
      it "should not save any record" do
        5.times{ @values << @value_hash }
        @options.merge!(:class_name => Test)
        lambda{ User.mass_insert(@values, @options) }.should raise_exception
      end
    end
  end
end
