class Item < ApplicationRecord
    enum status: { inactive: 0, active: 1 }
    default_scope { where(deleted_at: nil) }
    validates :name, presence: true
    mount_uploader :image, ImageUploader

    has_many :item_category_ships
    has_many :categories, through: :item_category_ships

    def destroy
        update(deleted_at: Time.current)
     end 
end