class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders.includes(:order_items).order(created_at: :desc)
  end

  def create
    Order.create!(
      user_id: current_user.id,
      total_price: current_user.shopping_cart_total_price
    )
    redirect_to orders_path
  end
end
