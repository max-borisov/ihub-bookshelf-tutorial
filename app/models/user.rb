class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :shopping_cart_items, dependent: :destroy
  has_many :books, through: :shopping_cart_items
  has_many :orders, dependent: :destroy

  validates :name, presence: true
end