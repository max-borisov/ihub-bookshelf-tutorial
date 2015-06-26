class ShoppingCartItemsController < ApplicationController
  def index
    @items = current_user.shopping_cart_items.joins(:book).order(created_at: :asc)
  end

  def create
    shopping_cart_item = current_user.shopping_cart_items.build(book_id: params[:book_id])
    book_title = Book.find(params[:book_id]).title
    if shopping_cart_item.save
      redirect_to :back, notice: "\"#{book_title}\" book has been added to your shopping cart"
    else
      redirect_to :back, danger: "\"#{book_title}\" could not be added to your shopping cart. Please, try again."
    end
  end

  def destroy
    shopping_cart_item = ShoppingCartItem.find(params[:id])
    if shopping_cart_item_belongs_to_user?(shopping_cart_item, current_user)
      shopping_cart_item.destroy
      redirect_to shopping_cart_items_path, success: "\"#{shopping_cart_item.book.title}\" has been removed for the shopping cart"
    else
      redirect_to root_path
    end
  end

  private
    def shopping_cart_item_belongs_to_user?(item, user)
      item.user_id == user.id
    end
end
