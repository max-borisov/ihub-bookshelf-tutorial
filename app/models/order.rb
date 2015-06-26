class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items, dependent: :destroy
  after_save :create_items

  validates :user_id, :total_price, presence: true

  private
    def create_items
      user = User.find(user_id)
      shopping_cart_items = user.shopping_cart_items.pluck(:book_id)
      res = []
      shopping_cart_items.each { |book_id| res.push({ book_id: book_id, order_id: id }) }
      OrderItem.create!(res)
      user.shopping_cart_items.destroy_all
    end
end