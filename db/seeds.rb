# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

OrderItem.destroy_all
Order.destroy_all
ShoppingCartItem.destroy_all
Review.destroy_all
Book.destroy_all
User.destroy_all

require_relative('./seeds/users')
require_relative('./seeds/books')
require_relative('./seeds/reviews')
require_relative('./seeds/shopping_cart_items')
require_relative('./seeds/orders')
require_relative('./seeds/order_items')