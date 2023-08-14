class CreateOffers < ActiveRecord::Migration[7.0]
  def change
    create_table :offers do |t|
      t.string :image
      t.string :name
      t.string :genre
      t.string :status
      t.integer :amount
      t.integer :coin
      t.timestamps
    end
  end
end
