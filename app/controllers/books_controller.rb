class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.order(created_at: :asc).all
  end

  def new
  end

  def create
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
    @review = Review.new
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
