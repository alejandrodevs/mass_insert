ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string :name
    t.boolean :active
    t.integer :age
    t.decimal :money, precision: 10, scale: 2
    t.date :birth_date
    t.timestamps null: false
  end

  create_table :kinds, force: true do |t|
    t.string :name
    t.index ['name'], name: 'index_kinds_on_name', unique: true, using: :btree
  end

  create_table :posts, force: true, id: false do |t|
    t.integer :id, primary_key: true
    t.string :name
  end
end
