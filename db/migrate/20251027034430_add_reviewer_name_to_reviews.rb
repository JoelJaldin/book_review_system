class AddReviewerNameToReviews < ActiveRecord::Migration[7.1]
  def change
    add_column :reviews, :reviewer_name, :string, null: false
  end
end
