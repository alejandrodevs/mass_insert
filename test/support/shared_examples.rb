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

    after :each do
      User.delete_all
      Post.delete_all
    end

    describe 'Column types' do
      def setup
        User.mass_insert([attributes])
      end

      def user
        @user ||= User.last
      end

      it 'saves values correctly' do
        assert_equal 'User Name', user.name
        assert_equal true, user.active
        assert_equal 25, user.age
        assert_equal 20.50, user.money
        assert_equal Date.today, user.birth_date
      end
    end

    describe 'Bulk inseting' do
      def array_of_values_with(size)
        Array.new(size) { attributes }
      end

      it 'saves 500 records correctly' do
        values = array_of_values_with(500)
        User.mass_insert(values)
        assert_equal 500, User.count
      end

      it 'saves 1000 records correctly' do
        values = array_of_values_with(1000)
        User.mass_insert(values)
        assert_equal 1000, User.count
      end
    end

    describe 'Primary key' do
      describe 'when primary key is true' do
        def setup
          Post.mass_insert([
            { id: 10_000, name: 'Post' }
          ], primary_key: true)
        end

        def post
          @post ||= Post.last
        end

        it 'saves values correctly' do
          assert_equal 10_000, post.id
        end
      end

      describe 'when primary key is false' do
        def setup
          User.mass_insert([
            attributes.merge(id: 10_000)
          ], primary_key: false)
        end

        def user
          @user ||= User.last
        end

        it 'saves values incorrectly' do
          refute_equal 10_000, user.id
        end
      end
    end
  end
end
