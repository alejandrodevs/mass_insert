require 'test_helper'

shared_examples

describe 'Database Adapters' do
  let(:attributes) do
    { name: 'Ruby' }
  end

  after :each do
    Kind.delete_all
  end

  describe 'with duplicated record' do
    def setup
      Kind.mass_insert([attributes])
    end

    it 'does not raises error if is duplicated and has the duplication handler on' do
      Kind.mass_insert([attributes], handle_duplication: true)
    end

    it 'raises error if is duplicated and does not have the duplication handler on' do
      assert_raises ActiveRecord::RecordNotUnique do
        Kind.mass_insert([attributes])
      end
    end
  end
end
