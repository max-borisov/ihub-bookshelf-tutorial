class BooksController < ApplicationController
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
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
