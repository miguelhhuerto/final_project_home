class Offer < ApplicationRecord
    belongs_to :order, optional: true
    enum status: { inactive: 0, active: 1 }
    # validates :amount, presence: true, if: -> { genre == 'deposit' }
    # validates :coins, presence: true, if: -> { genre == 'deposit' }
    enum genre: { one_time: 0, monthly: 1, weekly: 2, daily: 3, regular: 4 }
    mount_uploader :image, ImageUploader



end
