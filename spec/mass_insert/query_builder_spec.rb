require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::QueryBuilder do

  let!(:subject){ MassInsert::QueryBuilder.new([], {}) }

  describe "instance methods" do
    describe "#initialize" do

      let(:builder){ MassInsert::QueryBuilder.new("values", "options")

      it "should initialize the values attribute" do
        builder.values.should eq("values")
      end

      it "should initialize the options attribute" do
        builder.options.should eq("options")
      end
    end

    describe "#build" do
      it "should respond to build method" do
        expect(subject).to respond_to(:build)
      end

      it "should return the query string" do
        subject.stub(:adapter_class).and_return("adapter_class")
        subject.adapter_class.stub(:new).and_return("adapter_instance")
        subject.adapter_class.new.stub(:execute).and_return("query")
        expect(subject.build).to eq("query")
      end
    end

    describe "#adapter" do
      it "should respond to adapter method" do
        expect(subject).to respond_to(:adapter)
      end

      it "should return the adapter type" do
        config = {"config" => {:adapter => "sql"}}
        connection = ActiveRecord::Base.connection
        connection.stub(:instance_values).and_return(config)
        expect(subject.adapter).to eq("sql")
      end
    end

    describe "#adapter_class" do
      it "should respond to adapter_class method" do
        expect(subject).to respond_to(:adapter_class)
      end

      context "when adapter is mysql2" do
        it "should return a Mysql2Adapter instance" do
          subject.stub(:adapter).and_return("mysql2")
          instance_class = MassInsert::Adapters::Mysql2Adapter
          expect(subject.adapter_class).to eq(instance_class)
        end
      end

      context "when adapter is postgresql" do
        it "should return a PostgreSQLAdapter instance" do
          subject.stub(:adapter).and_return("postgresql")
          instance_class = MassInsert::Adapters::PostgreSQLAdapter
          expect(subject.adapter_class).to eq(instance_class)
        end
      end

      context "when adapter is sqlite3" do
        it "should return a SQLite3Adapter instance" do
          subject.stub(:adapter).and_return("sqlite3")
          instance_class = MassInsert::Adapters::SQLite3Adapter
          expect(subject.adapter_class).to eq(instance_class)
        end
      end

      context "when adapter is sqlserver" do
        it "should return a SQLServerAdapter instance" do
          subject.stub(:adapter).and_return("sqlserver")
          instance_class = MassInsert::Adapters::SQLServerAdapter
          expect(subject.adapter_class).to eq(instance_class)
        end
      end
    end
  end
end
