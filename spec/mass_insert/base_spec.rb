require './spec/spec_helper'
require "./lib/mass_insert"
require "./spec/dummy_models/test"

describe MassInsert::Base do
  describe "class methods" do
    describe ".mass_insert" do
      before :each do
        MassInsert::ProcessControl.any_instance.stub(:start => true)
      end

      it "should respond to mass_insert class method" do
        Test.respond_to?(:mass_insert).should be_true
      end

      it "should can receive values and many options" do
        values  = [{:name => "name"}]
        options = {:option_one => "one", :option_two => "two"}
        Test.mass_insert(values, options).should be_true
      end

      it "should can receive only values" do
        values  = [{:name => "name"}]
        Test.mass_insert(values).should be_true
      end

      it "should not can called with values" do
        lambda{ Test.mass_insert }.should raise_error
      end

      it "should call execute ProcessControl method" do
        process = MassInsert::ProcessControl.any_instance
        process.should_receive(:start).exactly(1).times
        Test.mass_insert([], {})
      end

      it "should call mass_insert_options method" do
        Test.any_instance.stub(:mass_insert_options)
        Test.should_receive(:mass_insert_options).exactly(1).times
        Test.mass_insert([], {})
      end
    end

    describe ".mass_insert_results" do
      it "should respond to mass_insert_results class method" do
        Test.respond_to?(:mass_insert_results).should be_true
      end

      context "when mass_insert_process instance variable exists" do
        it "should call results method in ProcessControl class" do
          process = MassInsert::ProcessControl
          process.any_instance.stub(:results).and_return(true)
          process.any_instance.should_receive(:results).exactly(1).times
          Test.mass_insert([], {})
          Test.mass_insert_results
        end
      end
    end

    describe ".mass_insert_options" do
      describe "class_name" do
        it "returns class name that call if that option doesn't exist" do
          options = Test.send(:mass_insert_options)
          options[:class_name].should eq(Test)
        end

        it "returns class_name option if is in the options" do
          args = {:class_name => "OtherClass"}
          options = Test.send(:mass_insert_options, args)
          options[:class_name].should eq("OtherClass")
        end
      end

      describe "table_name" do
        it "returns class table_name that call if options doesn't exist" do
          options = Test.send(:mass_insert_options)
          options[:table_name].should eq(Test.table_name)
        end

        it "returns table_name option if is in the options" do
          args = {:table_name => "OtherTable"}
          options = Test.send(:mass_insert_options, args)
          options[:table_name].should eq("OtherTable")
        end
      end

      describe "primary_key" do
        it "returns :id if option primary_key doesn't exist" do
          options = Test.send(:mass_insert_options)
          options[:primary_key].should eq(:id)
        end

        it "returns primary_key option if is in the options" do
          args = {:primary_key => :user_id}
          options = Test.send(:mass_insert_options, args)
          options[:primary_key].should eq(:user_id)
        end
      end

      describe "primary_key_mode" do
        it "returns :auto if option primary_key_mode doesn't exist" do
          options = Test.send(:mass_insert_options)
          options[:primary_key_mode].should eq(:auto)
        end

        it "returns primary_key_mode option if is in the options" do
          args = {:primary_key_mode => :manual}
          options = Test.send(:mass_insert_options, args)
          options[:primary_key_mode].should eq(:manual)
        end
      end
    end
  end
end
