class CreateDestinations < ActiveRecord::Migration[6.1]
  def change
    create_table :destinations do |t|

      t.timestamps
      t.date :departure_date, null: false
      t.date :return_date, null: false
      t.string :domestic_or_international, null: false
      t.string :country
      t.string :prefecture, null: false
      t.string :city
      t.string :landmark
      t.integer :post_id
      
    end
  end
end
