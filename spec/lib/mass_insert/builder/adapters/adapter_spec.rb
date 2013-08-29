require 'spec_helper'

describe MassInsert::Builder::Adapters::Adapter do
  let!(:subject){ described_class.new([], {}) }

  describe "#initialize" do
    it "initializes values" do
      expect(subject.values).to eq([])
    end

    it "initializes options" do
      expect(subject.options).to eq({})
    end
  end

  describe "#class_name" do
    it "returns class_name option value" do
      subject.options = {:class_name => "FakeModel"}
      expect(subject.class_name).to eq("FakeModel")
    end
  end

  describe "#primary_key" do
    it "returns primary_key option value" do
      subject.options = {:primary_key => true}
      expect(subject.primary_key).to be_true
    end
  end

  describe "#each_slice" do
    it "returns each_slice option value" do
      subject.options = {:each_slice => 10000}
      expect(subject.each_slice).to be 10000
    end
  end

  describe "#columns" do
    context "when instance columns variable isn't defined" do
      it "returns sanitized_columns result" do
        subject.stub(:sanitized_columns).and_return("sanitized_columns")
        expect(subject.columns).to eq("sanitized_columns")
      end
    end

    context "when instance columns variable has been defined" do
      it "returns instance columns variable" do
        subject.stub(:sanitized_columns).and_return("sanitized_columns")
        subject.columns
        subject.stub(:sanitized_columns).and_return("sanitized_columns_other")
        expect(subject.columns).to eq("sanitized_columns")
      end
    end
  end

  describe "#sanitized_columns" do
    before :each do
      subject.options.merge!({:class_name => User})
      User.stub(:column_names).and_return(["id", "name", "email"])
    end

    context "when primary_key is false" do
      it "returns the columns array without primary key column" do
        subject.options.merge!({:primary_key => false})
        expect(subject.columns).to eq([:name, :email])
      end
    end

    context "when primary key is true" do
      it "returns the columns array with primary key column" do
        subject.options.merge!({:primary_key => true})
        expect(subject.columns).to eq([:id, :name, :email])
      end
    end
  end

  describe "#timestamp?" do
    context "when respond to timestamp columns" do
      it "returns true" do
        subject.stub(:columns).and_return([:updated_at, :created_at])
        expect(subject.timestamp?).to be_true
      end
    end

    context "when doesn't respond to timestamp columns" do
      it "returns false" do
        subject.stub(:columns).and_return([:created_at])
        expect(subject.timestamp?).to be_false
      end
    end
  end

  describe "#timestamp_format" do
    it "returns default timestamp format" do
      expect(subject.timestamp_format).to eq("%Y-%m-%d %H:%M:%S.%6N")
    end
  end

  describe "#timestamp" do
    it "returns default timestamp value with correct format" do
      subject.stub(:timestamp_format).and_return("%Y-%m-%d %H:%M:%S")
      expect(subject.timestamp).to eq(Time.now.strftime("%Y-%m-%d %H:%M:%S"))
    end
  end

  describe "#timestamp_hash" do
    it "returns a timestamp hash" do
      timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
      subject.stub(:timestamp).and_return(timestamp)
      expect(subject.timestamp_hash).to eq({:created_at => timestamp, :updated_at => timestamp})
    end
  end

  describe "#values_per_insertion" do
    context "when each_slice option is not false" do
      it "returns each_slice value" do
        subject.options.merge!(each_slice: 10)
        expect(subject.values_per_insertion).to eq(10)
      end
    end

    context "when each_slice option is false" do
      it "returns length of values" do
        subject.values = [{}, {}]
        subject.options.merge!(each_slice: false)
        expect(subject.values_per_insertion).to eq(2)
      end
    end
  end
end
