class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :comment, null: false
      t.integer :member_id
      t.integer :post_id

      t.timestamps
    end
  end
end
