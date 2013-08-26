require 'spec_helper'

describe MassInsert::Base do
  describe "class methods" do
    describe ".mass_insert" do
      before :each do
        MassInsert::Process.any_instance.stub(:start => true)
      end

      it "should respond to mass_insert class method" do
        expect(Test).to respond_to(:mass_insert)
      end

      it "should can receive values and many options" do
        values  = [{:name => "name"}]
        options = {:option_one => "one", :option_two => "two"}
        expect(Test.mass_insert(values, options)).to be_true
      end

      it "should can receive only values" do
        values  = [{:name => "name"}]
        expect(Test.mass_insert(values)).to be_true
      end

      it "should not can called with values" do
        expect(lambda{ Test.mass_insert }).to raise_error
      end

      it "should call execute ProcessControl method" do
        process = MassInsert::Process.any_instance
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
        expect(Test).to respond_to(:mass_insert_results)
      end

      it "should call results method in ProcessControl class" do
        Test.mass_insert([], {})
        process = Test.instance_variable_get(:@mass_insert_process)
        MassInsert::Result.should_receive(:new).with(process)
        Test.mass_insert_results
      end

      it "returns a MassInsert::Result instance" do
        Test.mass_insert([], {})
        expect(Test.mass_insert_results).to be_an_instance_of(MassInsert::Result)
      end
    end

    describe ".mass_insert_options" do
      describe "class_name" do
        it "returns class name that call if that option doesn't exist" do
          options = Test.send(:mass_insert_options)
          expect(options[:class_name]).to eq(Test)
        end

        it "returns class_name option if is in the options" do
          args = {:class_name => "OtherClass"}
          options = Test.send(:mass_insert_options, args)
          expect(options[:class_name]).to eq("OtherClass")
        end
      end

      describe "primary_key" do
        it "returns :id if option primary_key doesn't exist" do
          options = Test.send(:mass_insert_options)
          expect(options[:primary_key]).to eq(false)
        end

        it "returns primary_key option if is in the options" do
          args = {:primary_key => true}
          options = Test.send(:mass_insert_options, args)
          expect(options[:primary_key]).to eq(true)
        end
      end
    end
  end
end
