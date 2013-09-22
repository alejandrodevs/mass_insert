class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :age
      t.decimal :money, :precision => 10, :scale => 4
      t.boolean :active
      t.binary :checked
      t.date :birthday

      t.timestamps
    end
  end
end
