class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.string :username
      t.string :phone_number
      t.string :image
      t.string :password
      t.timestamps
    end
  end
end
