class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:create, :destroy]

  def create
    @review = @book.reviews.build(review_params)
    @review.user_id = current_user.id
    respond_to do |format|
      if @review.save
        format.html { redirect_to book_path(@book), notice: 'New review has been added' }
        format.js   { render layout: false }
      else
        error_message = 'Review could not be saved'
        format.html { redirect_to book_path(@book), flash: { danger: error_message } }
        format.js   { render 'error', layout: false, locals: { message: error_message } }
      end
    end
  end

  def destroy
    if current_user.admin?
      result = @book.reviews.destroy(params[:id])
    else
      result = @book.reviews.where(user_id: current_user).destroy(params[:id])
    end
    respond_to do |format|
      if result
        format.html { redirect_to book_path(@book), notice: 'Review has been deleted' }
        format.js   {render layout: false}
      else
        error_message = 'Review could not be saved'
        format.html { redirect_to book_path(@book), danger: error_message }
        format.js   {render layout: false, locals: { message: error_message }}
      end
    end
  end

  private
  def review_params
    params.require(:review).permit(:text)
  end

  def set_book
    @book = Book.find(params[:book_id])
  end
end
