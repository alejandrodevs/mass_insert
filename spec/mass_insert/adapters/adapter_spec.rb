require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::Adapter do
  before :each do
    @adapter = MassInsert::Adapters::Adapter.new([], {})
  end

  subject{ @adapter }

  describe "instance methods" do
    describe "#initialize" do

      before :each do
        @values  = [{:name => "name"}]
        @options = {:option_one => 10}
        @adapter = MassInsert::Adapters::Adapter.new(@values, @options)
      end

      it "should initialize the values" do
        @adapter.values.should eq(@values)
      end

      it "should initialize the options" do
        @adapter.options.should eq(@options)
      end
    end

    describe "#class_name" do
      it "should respond to class name method" do
        subject.respond_to?(:class_name).should be_true
      end

      it "should returns the class_name in options" do
        subject.options = {:class_name => "User"}
        subject.class_name.should eq("User")
      end
    end

    describe "#table_name" do
      it "should respond to table_name method" do
        subject.respond_to?(:table_name).should be_true
      end

      it "should returns the table_name in options" do
        subject.options = {:table_name => "users"}
        subject.table_name.should eq("users")
      end
    end

    describe "#table_columns" do
      it "should respond to table_columns method" do
        subject.respond_to?(:table_columns).should be_true
      end

      it "should returns the table_columns in ActiveRecord class" do
        class Test
          def self.column_names
            ["id", "name", "email"]
          end
        end
        subject.options = {:class_name => Test}
        columns = [:id, :name, :email]
        subject.table_columns.should eq(columns)
      end
    end

    describe "#column_names" do
      it "should respond to column_names method" do
        subject.respond_to?(:column_names).should be_true
      end

      context "when primary_key is auto" do
        it "should return an array without primary key column" do
          class Test
            def self.column_names
              ["id", "name", "email"]
            end
          end
          subject.options.merge!({
            :class_name       => Test,
            :primary_key      => :id,
            :primary_key_mode => :auto
          })
          column_names = [:name, :email]
          subject.column_names.should eq(column_names)
        end
      end

      context "when primary key is manual" do
        it "should return an array with primary key column" do
          class Test
            def self.column_names
              ["id", "name", "email"]
            end
          end
          subject.options.merge!({
            :class_name       => Test,
            :primary_key      => :id,
            :primary_key_mode => :manual
          })
          column_names = [:id, :name, :email]
          subject.column_names.should eq(column_names)
        end
      end
    end

    describe "#primary_key" do
      it "should respond to primary_key method" do
        subject.respond_to?(:primary_key).should be_true
      end

      it "should returns the primary_key in options" do
        subject.options = {:primary_key => :user_id}
        subject.primary_key.should eq(:user_id)
      end
    end

    describe "#primary_key_mode" do
      it "should respond to primary_key_mode method" do
        subject.respond_to?(:primary_key_mode).should be_true
      end

      it "should returns the primary_key_mode in options" do
        subject.options = {:primary_key_mode => :auto}
        subject.primary_key_mode.should eq(:auto)
      end
    end

  end
end
