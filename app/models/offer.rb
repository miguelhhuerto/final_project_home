class Offer < ApplicationRecord
    belongs_to :order, optional: true
    enum status: { inactive: 0, active: 1 }
    validate :order_presence_for_deposit_genre
    validates :amount, presence: true, if: -> { genre == 'deposit' }
    validates :coins, presence: true, if: -> { genre == 'deposit' }
    validate :amount_for_genre
    mount_uploader :image, ImageUploader


    private

    def amount_for_genre
      if genre != 'deposit' && (amount.nil? || amount <= 0)
        errors.add(:amount, "must be greater than 0 for non-deposit genre")
      end
    end
end
