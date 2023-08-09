class Category < ApplicationRecord
  validates :name, presence: true
  default_scope { where(deleted_at: nil) }
  has_many :item_category_ships
  has_many :items, through: :item_category_ships

  
  def destroy
    update(deleted_at: Time.now)
  end
end
