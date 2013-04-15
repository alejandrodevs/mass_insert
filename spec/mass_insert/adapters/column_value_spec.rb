require './spec/spec_helper'
require "./lib/mass_insert"

describe MassInsert::Adapters::ColumnValue do
  before :each do
    @options = {
      :class_name				=> User,
      :table_name				=> "users",
      :primary_key			=> :id,
      :primary_key_mode => :auto
    }
    @row = {
      :name		=> "name",
      :email	=> "email",
      :age		=> 10
    }
    @colum_value = MassInsert::Adapters::ColumnValue.new(@row, :name, @options)
  end

  subject{ @colum_value }

  describe "#initialize" do
    it "should assign options param to option attribute" do
      subject.options.should eq(@options)
    end

    it "should assign column param to column attribute" do
      subject.column.should eq(:name)
    end

    it "should assign row param to row attribute" do
      subject.row.should eq(@row)
    end
  end

  describe "#column_type" do
    it "should respond to column_type method" do
      subject.respond_to?(:column_type).should be_true
    end

    context "when is a string column" do
      it "should return symbol :string" do
        subject.column = :name
        subject.column_type.should eq(:string)
      end
    end

    context "when is a integer column" do
      it "should return symbol :integer" do
        subject.column = :age
        subject.column_type.should eq(:integer)
      end
    end
  end

  describe "#colum_value" do
    it "should respond to column_value method" do
      subject.respond_to?(:column_value).should be_true
    end

    it "should return symbol :string" do
      subject.column = :age
      subject.column_value.should eq(10)
    end
  end

  describe "#build" do
    context "when is a string column" do
      context "when is an empty attribute" do
        it "should return ''" do
          subject.stub(:column_type).and_return(:string)
          subject.stub(:column_value).and_return(nil)
          subject.build.should eq("''")
        end
      end

      context "when is not an empty attribute" do
        it "should return 'name'" do
          subject.build.should eq("'name'")
        end
      end
    end

    context "when is a integer column" do
      context "when is an empty attribute" do
        it "should return an empty string" do
          subject.stub(:column_type).and_return(:integer)
          subject.stub(:column_value).and_return(nil)
          subject.build.should eq("0")
        end
      end

      context "when is not an empty attribute" do
        it "should return 'name'" do
          subject.column = :age
          subject.build.should eq("10")
        end
      end
    end

    context "when is a decimal column" do

    end

    context "when is a boolean column" do

    end
  end
end
