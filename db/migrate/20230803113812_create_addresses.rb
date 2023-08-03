class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :genre, default: 0
      t.string :name
      t.string :street_address
      t.string :phone_number
      t.string :remark
      t.boolean :is_default
      t.bigint "address_region_id"
      t.bigint "address_province_id"
      t.bigint "address_city_id"
      t.bigint "address_barangay_id"
      t.bigint "user_id"
      t.timestamps
    end
  end
end
