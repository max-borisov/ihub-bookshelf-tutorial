class ShoppingCartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @items = current_user.shopping_cart_items.joins(:book).order(created_at: :asc)
  end

  def create
    book_title = Book.find(params[:book_id]).title
    if build_shopping_cart_item.save
      redirect_to books_path, notice: "\"#{book_title}\" has been added to your shopping cart"
    else
      redirect_to book_path(params[:book_id]), flash: { danger: "\"#{book_title}\"
      could not be added to your shopping cart. Please, try again." }
    end
  end

  def destroy
    shopping_cart_item = ShoppingCartItem.find(params[:id])
    if shopping_cart_item.user_id == current_user.id
      shopping_cart_item.destroy
      redirect_to shopping_cart_items_path, notice: "\"#{shopping_cart_item.book.title}\"
      has been removed for the shopping cart"
    else
      redirect_to books_path
    end
  end

  private

  def build_shopping_cart_item
    current_user.shopping_cart_items.build(book_id: params[:book_id])
  end
end
