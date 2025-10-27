class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.references :book, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rating, null: false
      t.text :content, null: false

      t.timestamps
    end
    
    add_index :reviews, [:book_id, :created_at]
  end
end
