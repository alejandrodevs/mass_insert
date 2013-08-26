require 'spec_helper'

describe MassInsert::Builder::Adapters::Adapter do
  let!(:subject){ MassInsert::Builder::Adapters::Adapter.new([], {}) }

  describe "instance methods" do
    describe "#initialize" do
      let(:adapter){MassInsert::Builder::Adapters::Adapter.new("values", "options")}

      it "should initialize the values" do
        expect(adapter.values).to eq("values")
      end

      it "should initialize the options" do
        expect(adapter.options).to eq("options")
      end
    end

    describe "#class_name" do
      it "should returns the class_name in options" do
        subject.options = {:class_name => Test}
        expect(subject.class_name).to eq(Test)
      end
    end

    describe "#table_name" do
      it "should returns the table_name in options" do
        subject.options = {:table_name => "users"}
        expect(subject.table_name).to eq("users")
      end
    end

    describe "#columns" do
      before :each do
        subject.options.merge!({
          :class_name   => Test,
          :primary_key  => false
        })
      end

      it "should respond to columns method" do
        expect(subject).to respond_to(:columns)
      end

      context "when primary_key is false" do
        it "should return an array without primary key column" do
          column_names = [:name, :email]
          expect(subject.columns).to eq(column_names)
        end
      end

      context "when primary key is true" do
        it "should return an array with primary key column" do
          subject.options.merge!({:primary_key => true})
          columns_expected = [:id, :name, :email]
          expect(subject.columns).to eq(columns_expected)
        end
      end
    end

    describe "#primary_key" do
      it "should returns the primary_key in options" do
        subject.options = {:primary_key => :user_id}
        expect(subject.primary_key).to eq(:user_id)
      end
    end

    describe "#primary_key_mode" do
      it "should returns the primary_key_mode in options" do
        subject.options = {:primary_key_mode => :auto}
        expect(subject.primary_key_mode).to eq(:auto)
      end
    end

    describe "#sanitized_columns" do
      before :each do
        options = {
          :class_name       => Test,
          :primary_key      => false
        }
        subject.options.merge!(options)
      end

      it "should respond to sanitized_columns" do
        expect(subject).to respond_to(:sanitized_columns)
      end

      context "when primary_key_mode is false" do
        it "should returns the column without primary_key" do
          expect(subject.sanitized_columns).to eq([:name, :email])
        end
      end

      context "when primary_key is true" do
        it "should returns the columns including primary_key" do
          subject.options.merge!(:primary_key => true)
          expect(subject.sanitized_columns).to eq([:id, :name, :email])
        end
      end
    end

    describe "#table_columns" do
      it "should respond to table_columns method" do
        expect(subject).to respond_to(:table_columns)
      end

      it "should returns the table_columns in ActiveRecord class" do
        subject.options = {:class_name => Test}
        columns = [:id, :name, :email]
        expect(subject.table_columns).to eq(columns)
      end
    end

    describe "#timestamp?" do
      it "should respond_to timestamp? method" do
        expect(subject).to respond_to(:timestamp?)
      end

      context "when respond to timestamp columns" do
        it "should return true" do
          subject.stub(:columns).and_return([:updated_at, :created_at])
          expect(subject.timestamp?).to be_true
        end
      end

      context "when not respond to timestamp columns" do
        it "should return false" do
          subject.stub(:columns).and_return([:created_at])
          expect(subject.timestamp?).to be_false
        end
      end
    end

    describe "#timestamp_format" do
      it "should respond_to timestamp_format method" do
        expect(subject).to respond_to(:timestamp_format)
      end

      it "should return the default timestamp format" do
        expect(subject.timestamp_format).to eq("%Y-%m-%d %H:%M:%S.%6N")
      end
    end

    describe "#timestamp" do
      it "should respond_to timestamp method" do
        expect(subject).to respond_to(:timestamp)
      end

      it "should return the default timestamp value with correct format" do
        subject.stub(:timestamp_format).and_return("%Y-%m-%d %H:%M:%S")
        timestamp_value = Time.now.strftime("%Y-%m-%d %H:%M:%S")
        expect(subject.timestamp).to eq(timestamp_value)
      end
    end

    describe "#timestamp_hash" do
      it "should respond_to timestamp_hash method" do
        expect(subject).to respond_to(:timestamp_hash)
      end

      context "when have high precision" do
        it "should no be equals" do
          timestamp_hash_expected = {
            :created_at => subject.timestamp,
            :updated_at => subject.timestamp
          }
          expect(subject.timestamp_hash).not_to eq(timestamp_hash_expected)
        end
      end

      context "when do not have precision" do
        it "should be equals" do
          subject.stub(:timestamp_format).and_return("%Y-%m-%d %H:%M:%S")
          timestamp_hash_expected = {
            :created_at => subject.timestamp,
            :updated_at => subject.timestamp
          }
          expect(subject.timestamp_hash).to eq(timestamp_hash_expected)
        end
      end
    end
  end
end
