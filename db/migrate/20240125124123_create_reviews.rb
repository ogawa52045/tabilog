class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      
      t.timestamps
      t.references :member, null: false, foreign_key: true
      t.references :destination, null: false, foreign_key: true
      t.integer :star
      t.text :review_comment
    end
  end
end
