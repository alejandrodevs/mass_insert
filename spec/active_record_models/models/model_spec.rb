require './spec/spec_helper'
require "./lib/mass_insert"

describe "Model" do

  before :each do
    @values, @options  = [], {}
    @basic_values = {
      :name    => "some_name",
      :email   => "some_email",
      :age     => 20,
      :active  => true,
      :checked => true
    }
    User.delete_all
  end

  context "when is used without options" do
    it "should save 10 record into users table" do
      10.times{ @values << @basic_values }
      User.mass_insert(@values, @options)
      User.count.should eq(10)
    end

    it "should save if values cointains 2000 records" do
      2000.times{ @values << @basic_values }
      User.mass_insert(@values, @options)
      User.count.should eq(2000)
    end
  end

  context "when is used with options" do
    context "when the table name doesn't exit" do
      it "should not save any record" do
        10.times{ @values << @basic_values }
        @options.merge!(:table_name => "countries")
        lambda{ User.mass_insert(@values, @options) }.should raise_exception
      end
    end

    context "when the class name not inherit from ActiveRecord" do
      it "should not save any record" do
        10.times{ @values << @basic_values }
        InvalidClass = 1
        @options.merge!(:class_name => InvalidClass)
        lambda{ User.mass_insert(@values, @options) }.should raise_exception
      end
    end
  end
end
