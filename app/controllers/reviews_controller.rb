class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [:destroy]
  before_action :require_login, only: [:create]

  def create
    @review = build_review_with_user

    if @review.save
      redirect_to @book, notice: t('flash.notice.review_created')
    else
      render_review_creation_error
    end
  end

  def destroy
    @review.destroy
    redirect_to @book, notice: t('flash.notice.review_destroyed')
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_review
    @review = @book.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :content, :reviewer_name)
  end

  def build_review_with_user
    review = @book.reviews.build(review_params)
    review.user = current_user
    review.reviewer_name = current_user.name
    review
  end

  def render_review_creation_error
    @reviews = @book.reviews.includes(:user).order(created_at: :desc)
    render 'books/show', status: :unprocessable_entity
  end
end
