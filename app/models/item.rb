class Item < ApplicationRecord
    enum status: { inactive: 0, active: 1 }
    default_scope { where(deleted_at: nil) }
    validates :name, presence: true
    mount_uploader :image, ImageUploader
    has_many :item_category_ships
    has_many :categories, through: :item_category_ships
    has_many :bets
    has_many :winners
    
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
      transitions from: :started, to: :ended, guard: :before_ended?, success: :pick_winner
    end

    event :cancel do
      transitions from: [:started, :paused], to: :canceled, success: :cancel_bets
    end

    
  end

  def pick_winner
    batch_bets = self.bets.where(batch_count: self.batch_count)
    winner = batch_bets.sample
    winner.update(state: 'won')
    bets.where.not(state: 'won').update(state: 'lost')
    Winner.create(bet_id: winner.id, 
                  user_id: winner.user_id,
                  item_id: self.id,
                  item_batch_count: winner.batch_count
                 )
  end

  def before_ended?
    (self.bets.count) / (self.minimum_bets)*(self.batch_count) >= 1
  end

  def cancel_bets
    bets.where(state: 'betting').each do |bet|
      bet.cancel!
    end
  end
  
  def revise_quantity_and_batch_count
    self.update(quantity: self.quantity - 1)
    self.update(batch_count: self.batch_count + 1)
    self.update(number_count: 0)
  end

  def destroy
    if self.bets.count == 0
      update(deleted_at: Time.current)
    else
      errors.add(:base, 'Cannot Delete Items With Bets')
    end
  end
  

  private

  def allow_transition?
    self.quantity > 0 && self.status == "active" && Time.current < self.offline_at
  end
end