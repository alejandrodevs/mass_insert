require './spec/spec_helper'
require "./lib/mass_insert"

describe "User" do

  before :each do
    @values  = []
    @options = {}
  end

  after :each do
    User.delete_all
  end

  context "when is used without options" do
    it "should save 1000 record into users table" do
      10.times do
        @values << {
          :name   => "some_name",
          :email  => "some_email",
          :age    => 20
        }
      end
      User.mass_insert(@values, @options)
      User.count.should eq(10)
    end
  end

  context "when is used with options" do
    context "when the table name params doesn't exit" do
      it "should save 1000 record into users table" do
        10.times do
          @values << {
            :name   => "some_name",
            :email  => "some_email",
            :age    => 20
          }
        end
        @options = {:table_name => "countries"}
        begin
          User.mass_insert(@values, @options)
        rescue
          User.count.should eq(0)
        end
      end
    end
  end
end
