def shared_examples
  describe 'Database Adapters' do
    let(:attributes) do
      {
        name: 'User Name',
        active: true,
        age: 25,
        money: 20.50,
        birth_date: Date.today,
        created_at: DateTime.now,
        updated_at: DateTime.now
      }
    end

    before :each do
      User.delete_all
    end

    describe 'Column types' do
      def setup
        User.mass_insert([attributes])
      end

      def user
        @user ||= User.last
      end

      it 'saves values correctly' do
        assert_equal user.name, 'User Name'
        assert_equal user.active, true
        assert_equal user.age, 25
        assert_equal user.money, 20.50
        assert_equal user.birth_date, Date.today
      end
    end

    describe 'Bulk inseting' do
      def array_of_values_with(size)
        (0...size).map do |i|
          attributes
        end
      end

      describe '500 records' do
        it 'saves them correctly' do
          values = array_of_values_with(500)
          User.mass_insert(values)
          assert_equal User.count, 500
        end
      end

      describe '1000 records' do
        it 'saves them correctly' do
          values = array_of_values_with(1000)
          User.mass_insert(values)
          assert_equal User.count, 1000
        end
      end
    end
  end
end
