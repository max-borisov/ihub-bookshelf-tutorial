class Book < ActiveRecord::Base
  has_many :reviews, dependent: :destroy

  validates :title, :author, :pub_date, :price, :isbn, :description, presence: true
  validates :title, :author, length: { maximum: 150 }
  validates :isbn, length: { maximum: 12 }, format: { with: /[\d\-]+/ }
  validates :amazon_id, length: { maximum: 50 }, format: { with: /[\dA-Z]+/ }
  validates :isbn, :amazon_id, uniqueness: { message: 'is not unique' }
  validates :price, numericality: true
end