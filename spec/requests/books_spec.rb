require 'rails_helper'

RSpec.describe "Books", type: :request do
  let(:admin_user) { create(:user, role: "admin") }
  
  before do
    post "/login", params: { email: admin_user.email, password: "password123" }
  end
  
  describe "GET /books" do
    it "returns http success" do
      get "/books"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /books/:id" do
    let(:book) { create(:book) }
    
    it "returns http success" do
      get "/books/#{book.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /books" do
    it "creates a new book" do
      expect {
        post "/books", params: { book: { title: "Test Book", author: "Test Author" } }
      }.to change(Book, :count).by(1)
    end

    it "redirects to book show page" do
      post "/books", params: { book: { title: "Test Book", author: "Test Author" } }
      expect(response).to have_http_status(:redirect)
      follow_redirect!
      expect(response).to have_http_status(:success)
      expect(response.body).to include("Test Book")
    end

    it "does not create book with blank title" do
      expect {
        post "/books", params: { book: { title: "", author: "Test Author" } }
      }.not_to change(Book, :count)
    end

    it "does not create book with blank author" do
      expect {
        post "/books", params: { book: { title: "Test Book", author: "" } }
      }.not_to change(Book, :count)
    end
  end

  describe "DELETE /books/:id" do
    let(:book) { create(:book) }

    it "deletes a book" do
      book # Create book first
      expect {
        delete "/books/#{book.id}"
      }.to change(Book, :count).by(-1)
    end

    it "deletes associated reviews" do
      review = create(:review, book: book)
      expect {
        delete "/books/#{book.id}"
      }.to change(Review, :count).by(-1)
    end
  end
end
