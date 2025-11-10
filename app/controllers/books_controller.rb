class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]

  def index
    @books = Book.includes(:reviews).order(:title)
  end

  def show
    # Scopes de Review
    @reviews = @book.reviews.with_users.ordered_by_created
    @review = @book.reviews.build
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: t('flash.notice.book_created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: t('flash.notice.book_updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, notice: t('flash.notice.book_destroyed')
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author)
  end
end
