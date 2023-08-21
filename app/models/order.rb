class Order < ApplicationRecord
    belongs_to :user
    belongs_to :offer, optional: true
    enum genre: { deposit: 0, increase: 1, deduct: 2, bonus: 3, share: 4}
    validate :amount_for_genre  
    validates :offer, presence: true, if: :deposit_genre?
    after_create :assign_serial_number

include AASM

    aasm column: :state do
      state :pending, initial: true
      state :submitted, :canceled, :paid

    event :submit do
      transitions from: :pending, to: :submitted, guard: :allow_transition?, success: :revise_quantity_and_batch_count
    end

    event :cancel do
      transitions from: [:pending, :submitted, :paid], to: :canceled, guard: :allow_transition?,success: :change_coins_canceled
    end

    event :pay do
      transitions from: :submitted, to: :paid, guard: :before_ended?, success: :change_coins_paid
    end

  end

  def assign_serial_number
    number_count = user.orders.count
    serial_number = "#{Time.current}-#{order.id}-#{user_id}-#{number_count}"
    self.update(serial_number: serial_number)
  end

  def change_coins_paid
    return unless status == 'submitted'

    if self.genre == 'deposit'
      user.increment!(:total_deposit, amount)
    end

    if self.genre == 'deduct'
      user.decrement!(:coin, amount)
    else
      user.increment!(:coin, amount)
    end
  end

  def change_coins_canceled
    return unless status == 'paid'

    if self.genre == 'deposit'
      user.decrement!(:total_deposit, amount)
    end

    if self.genre != 'deduct'
      user.decrement!(:coin, amount)
    else
      user.increment!(:coin, amount)
    end
  end

  def allow_transition?
    user.coins >= amount
  end

  private

  def amount_for_genre
    if genre != 'deposit' && (amount.present? && amount <= 0)
      errors.add(:amount, "must be greater than 0 for non-deposit genre")
    end
  end

  def deposit_genre?
    genre == 'deposit'
  end
end
