ActiveRecord::Schema.define do
  create_table :users, force: true do |t|
    t.string  :name
    t.boolean :active
    t.integer :age
    t.decimal :money, precision: 10, scale: 2
    t.date    :birth_date

    t.timestamps
  end
end
