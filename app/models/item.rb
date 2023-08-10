class Item < ApplicationRecord
    enum status: { inactive: 0, active: 1 }
    default_scope { where(deleted_at: nil) }
    validates :name, presence: true
    mount_uploader :image, ImageUploader
    has_many :item_category_ships
    has_many :categories, through: :item_category_ships

    include AASM

    aasm column: :state do
      state :pending, initial: true
      state :started, :paused, :ended, :canceled

    event :start do
      transitions from: [:pending, :paused, :ended, :canceled], to: :started, guard: :allow_transition?, success: :revise_quantity_and_batch_count
    end

    event :pause do
      transitions from: :started, to: :paused
    end

    event :end do
      transitions from: :started, to: :ended
    end

    event :cancel do
      transitions from: [:started, :paused], to: :canceled
    end

    
  end

  def revise_quantity_and_batch_count
    self.update(quantity: self.quantity + 1)
    self.update(batch_count: self.batch_count - 1)
  end

  def allow_transition?
    aasm.from_state == :paused || (self.quantity > 0 && self.status == "active" && Time.now < self.offline_at)
  end


  def destroy
    update(deleted_at: Time.current)
  end 

    private
     
end