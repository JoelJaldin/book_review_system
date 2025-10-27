require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'validations' do
    it 'debe tener una calificación entre 1 y 5' do
      review = build(:review, rating: 0)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include('debe estar entre 1 y 5')

      review = build(:review, rating: 6)
      expect(review).not_to be_valid
      expect(review.errors[:rating]).to include('debe estar entre 1 y 5')

      review = build(:review, rating: 3)
      expect(review).to be_valid
    end

    it 'debe tener un contenido de máximo 1000 caracteres' do
      long_content = 'a' * 1001
      review = build(:review, content: long_content)
      expect(review).not_to be_valid
      expect(review.errors[:content]).to include('es demasiado largo (máximo 1000 caracteres)')

      short_content = 'a' * 1000
      review = build(:review, content: short_content)
      expect(review).to be_valid
    end

    it 'debe tener un libro asociado' do
      review = build(:review, book: nil)
      expect(review).not_to be_valid
    end

    it 'debe tener un usuario asociado' do
      review = build(:review, user: nil)
      expect(review).not_to be_valid
    end
  end

  describe 'associations' do
    it 'debe pertenecer a un libro' do
      review = create(:review)
      expect(review.book).to be_a(Book)
    end

    it 'debe pertenecer a un usuario' do
      review = create(:review)
      expect(review.user).to be_a(User)
    end
  end
end
