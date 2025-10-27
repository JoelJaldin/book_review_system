class ReviewsController < ApplicationController
  before_action :set_book
  before_action :set_review, only: [:destroy]

  def create
    @review = build_review_with_user

    if @review.save
      redirect_to @book, notice: 'Reseña creada exitosamente.'
    else
      render_review_creation_error
    end
  end

  def destroy
    @review.destroy
    redirect_to @book, notice: 'Reseña eliminada exitosamente.'
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
    review.user = find_or_create_user(review.reviewer_name)
    review
  end

  def find_or_create_user(name)
    # Buscar usuario existente no baneado con ese nombre
    User.find_or_create_by(name: name, banned: false) do |user|
      user.email = generate_email_for_name(name)
      user.banned = false
    end
  end

  def generate_email_for_name(name)
    "#{name.downcase.gsub(/\s+/, '_')}@example.com"
  end

  def render_review_creation_error
    @reviews = @book.reviews.includes(:user).order(created_at: :desc)
    render 'books/show', status: :unprocessable_entity
  end
end
