class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :user_id
      t.string :offer_id
      t.string :serial_number
      t.string :state
      t.integer :amount
      t.integer :coin
      t.string :remarks
      t.integer :genre, default: 0

      t.timestamps
    end
  end
end
