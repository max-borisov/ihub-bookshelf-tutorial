class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, except: [:index, :search, :show]

  def index
    @books = Book.paginate(:page => params[:page], :per_page => per_page).order(created_at: :asc)
  end

  def search
    @books = Book.search(params[:keywords]).paginate(:page => params[:page], :per_page => per_page).order(created_at: :asc)
    render :index
  end

  def show
    @reviews = @book.reviews
    @review = Review.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated'
    else
      render :edit
    end
  end

  def destroy
    title = @book.title
    @book.destroy
    redirect_to books_path, notice: "Book \"#{title}\" has been deleted"
  end

  private
  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :pub_date, :description, :price, :isbn, :amazon_id)
  end

  def admin_only
    redirect_to books_path, flash: { alert: 'Only admin can manage books' } unless current_user.admin?
  end

  def per_page
    5
  end
end
