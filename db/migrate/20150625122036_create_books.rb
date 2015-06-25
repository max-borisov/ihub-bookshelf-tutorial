class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.date :pub_date
      t.string :amazon_id
      t.string :isbn

      t.timestamps null: false
    end
    add_index :books, :amazon_id, unique: true
    add_index :books, :isbn, unique: true
  end
end
