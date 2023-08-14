class CreateWinners < ActiveRecord::Migration[7.0]
  def change
    create_table :winners do |t|
      t.string :item_id
      t.string :bet_id
      t.string :user_id
      t.string :address_id
      t.integer :item_batch_count
      t.string :state
      t.float :price
      t.datetime :paid_at
      t.string :admin_id
      t.string :picture
      t.string :comment
      t.timestamps
    end
  end
end



