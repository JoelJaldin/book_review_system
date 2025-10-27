require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do
    it 'debe tener muchas reseñas' do
      book = create(:book)
      review1 = create(:review, book: book)
      review2 = create(:review, book: book)
      
      expect(book.reviews).to include(review1, review2)
    end
  end

  describe '#average_rating' do
    it 'debe calcular el promedio de calificaciones correctamente' do
      book = create(:book)
      create(:review, book: book, rating: 4)
      create(:review, book: book, rating: 5)
      create(:review, book: book, rating: 3)
      
      expect(book.average_rating).to eq(4.0)
    end

    it 'debe redondear el promedio a una décima' do
      book = create(:book)
      create(:review, book: book, rating: 4)
      create(:review, book: book, rating: 5)
      create(:review, book: book, rating: 4)
      
      expect(book.average_rating).to eq(4.3)
    end

    it 'debe excluir reseñas de usuarios baneados' do
      book = create(:book)
      user_banned = create(:user, banned: true)
      user_normal1 = create(:user, banned: false)
      user_normal2 = create(:user, banned: false)
      user_normal3 = create(:user, banned: false)
      
      create(:review, book: book, user: user_banned, rating: 1)
      create(:review, book: book, user: user_normal1, rating: 5)
      create(:review, book: book, user: user_normal2, rating: 5)
      create(:review, book: book, user: user_normal3, rating: 5)
      
      expect(book.average_rating).to eq(5.0)
    end

    it 'debe retornar "Reseñas Insuficientes" cuando hay menos de 3 reseñas' do
      book = create(:book)
      create(:review, book: book, rating: 5)
      create(:review, book: book, rating: 4)
      
      expect(book.average_rating).to eq("Reseñas Insuficientes")
    end

    it 'debe retornar "Reseñas Insuficientes" cuando no hay reseñas' do
      book = create(:book)
      expect(book.average_rating).to eq("Reseñas Insuficientes")
    end

    it 'debe contar solo reseñas de usuarios no baneados para el mínimo de 3' do
      book = create(:book)
      user_banned = create(:user, banned: true)
      user_normal = create(:user, banned: false)
      
      create(:review, book: book, user: user_banned, rating: 1)
      create(:review, book: book, user: user_normal, rating: 5)
      create(:review, book: book, user: user_normal, rating: 4)
      
      expect(book.average_rating).to eq("Reseñas Insuficientes")
    end
  end
end
