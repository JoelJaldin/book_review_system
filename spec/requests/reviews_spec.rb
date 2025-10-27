require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:book) { create(:book) }
  let(:user) { create(:user) }
  let(:admin_user) { create(:user, role: "admin") }
  let(:review) { create(:review, book: book, user: user) }

  describe "POST /books/:book_id/reviews" do
    before do
      post "/login", params: { email: user.email, password: "password123" }
    end
    
    it "creates a new review with valid params" do
      expect {
        post "/books/#{book.id}/reviews", params: { 
          review: { rating: 5, content: "Excelente libro!", reviewer_name: user.name } 
        }
      }.to change(Review, :count).by(1)
    end

    it "does not create review without content" do
      expect {
        post "/books/#{book.id}/reviews", params: { 
          review: { rating: 5, content: "", reviewer_name: user.name } 
        }
      }.not_to change(Review, :count)
    end

    it "does not create review with content over 1000 characters" do
      long_content = 'a' * 1001
      expect {
        post "/books/#{book.id}/reviews", params: { 
          review: { rating: 5, content: long_content, reviewer_name: user.name } 
        }
      }.not_to change(Review, :count)
    end
  end

  describe "DELETE /books/:book_id/reviews/:id" do
    before do
      post "/login", params: { email: admin_user.email, password: "password123" }
    end
    
    it "deletes a review" do
      review
      expect {
        delete "/books/#{book.id}/reviews/#{review.id}"
      }.to change(Review, :count).by(-1)
    end

    it "redirects to book page after deletion" do
      delete "/books/#{book.id}/reviews/#{review.id}"
      expect(response).to redirect_to(book)
    end
  end
end
