class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :total_price, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
