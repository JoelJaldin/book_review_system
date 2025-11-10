class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [:destroy]
  before_action :require_login, only: [:create]

  def create
    # Refactorización: usar método de clase build_for_user del modelo Review
    @review = Review.build_for_user(@book, current_user, review_params)

    if @review.save
      redirect_to @book, notice: t('flash.notice.review_created')
    else
      # Scopes de Review
      load_reviews_for_error
      render 'books/show', status: :unprocessable_entity
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

  # Refactorización: eliminado :reviewer_name de params, se setea en modelo con callback
  def review_params
    params.require(:review).permit(:rating, :content)
  end

  # Scopes de Review
  def load_reviews_for_error
    @reviews = @book.reviews.with_users.ordered_by_created
  end
end
