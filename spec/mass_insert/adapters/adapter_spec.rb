require './spec/spec_helper'
require "./lib/mass_insert"
require "./spec/dummy_models/test"

describe MassInsert::Adapters::Adapter do
  let!(:subject){ MassInsert::Adapters::Adapter.new([], {}) }

  describe "instance methods" do
    describe "#initialize" do
      let(:adapter){MassInsert::Adapters::Adapter.new("values", "options")}

      it "should initialize the values" do
        expect(adapter.values).to eq("values")
      end

      it "should initialize the options" do
        expect(adapter.options).to eq("options")
      end
    end

    describe "#class_name" do
      it "should respond to class name method" do
        expect(subject).to respond_to(:class_name)
      end

      it "should returns the class_name in options" do
        subject.options = {:class_name => Test}
        expect(subject.class_name).to eq(Test)
      end
    end

    describe "#table_name" do
      it "should respond to table_name method" do
        expect(subject).to respond_to(:table_name)
      end

      it "should returns the table_name in options" do
        subject.options = {:table_name => "users"}
        expect(subject.table_name).to eq("users")
      end
    end

    describe "#column_names" do
      before :each do
        subject.options.merge!({
          :class_name       => Test,
          :primary_key      => :id,
          :primary_key_mode => :auto
        })
      end

      it "should respond to column_names method" do
        expect(subject).to respond_to(:column_names)
      end

      context "when primary_key is auto" do
        it "should return an array without primary key column" do
          column_names = [:name, :email]
          expect(subject.column_names).to eq(column_names)
        end
      end

      context "when primary key is manual" do
        it "should return an array with primary key column" do
          subject.options.merge!({:primary_key_mode => :manual})
          column_names = [:id, :name, :email]
          expect(subject.column_names).to eq(column_names)
        end
      end
    end

    describe "#primary_key" do
      it "should respond to primary_key method" do
        expect(subject).to respond_to(:primary_key)
      end

      it "should returns the primary_key in options" do
        subject.options = {:primary_key => :user_id}
        expect(subject.primary_key).to eq(:user_id)
      end
    end

    describe "#primary_key_mode" do
      it "should respond to primary_key_mode method" do
        expect(subject).to respond_to(:primary_key_mode)
      end

      it "should returns the primary_key_mode in options" do
        subject.options = {:primary_key_mode => :auto}
        expect(subject.primary_key_mode).to eq(:auto)
      end
    end

  end
end
