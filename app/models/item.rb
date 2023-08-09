class Item < ApplicationRecord
    enum status: { inactive: 0, active: 1 }
    default_scope { where(deleted_at: nil) }
    validates :name, presence: true
    mount_uploader :image, ImageUploader
    has_many :item_category_ships
    has_many :categories, through: :item_category_ships

    include AASM
    after_create :assign_serial_number

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
    item.update(quantity: item.quantity + 1)
    item.update(batch_count: item.batch_count - 1)
  end

  def allow_transition?
    aasm.from_state == :paused || (item.quantity > 0 && item.status == "active" && Time.now < item.offline_at)
  end


  def destroy
    update(deleted_at: Time.current)
  end 

    private
     
    def assign_serial_number
      self.update(serial_number: "gem-#{id.to_s.rjust(9, '0')}")
    end
end