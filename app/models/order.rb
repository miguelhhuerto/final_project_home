class Order < ApplicationRecord
    attr_accessor :admin_balance_view
    belongs_to :user
    belongs_to :offer, optional: true
    enum genre: { deposit: 0, increase: 1, deduct: 2, bonus: 3, share: 4}
    validates :amount, numericality: {greater_than: 0}, if: :deposit?
    validates :offer, presence: true, if: :deposit?
    validates :coins, numericality: {greater_than: 0}
    after_create :assign_serial_number
    validates :remarks, presence: true, if: -> { self.admin_balance_view }


include AASM

    aasm column: :state do
      state :pending, initial: true
      state :submitted, :canceled, :paid

    event :submit do
      transitions from: :pending, to: :submitted
    end

    event :cancel do
      transitions from: [:pending, :submitted], to: :canceled
      transitions from: :paid, to: :canceled, guard: :can_return_user_coins?, success: [:decrease_coins_canceled,:change_coins_canceled]
    end

    event :pay do
      transitions from: :submitted, to: :paid, guard: :deposit?, success: [:increase_total_deposit,:change_coins_paid]
      transitions from: :pending, to: :paid, guard: :can_deduct_user_coins?, success: :change_coins_paid
    end

  end


  def can_deduct_user_coins?
    return true if ( !deduct? || (deduct? && user.coins >= coins))
    errors.add(:base, "User Coins Not Sufficient")
  end

  def assign_serial_number
    
    formatted_date = Time.current.strftime('%y%m%d')
    order_id = self.id
    number_count = user.orders.count
    serial_number = "#{formatted_date}-#{order_id}-#{number_count}"
    
    self.update(serial_number: serial_number)
  end

  def increase_total_deposit
    if deposit?
      user.increment!(:total_deposit, amount)
    end
  end

  def change_coins_paid
    if deduct?
      user.decrement!(:coins, coins)
    else
      user.increment!(:coins, coins)
    end
  end

  def decrease_coins_canceled
    if deposit?
      user.decrement!(:total_deposit, amount)
    end
  end

  def change_coins_canceled
    if !deduct?
      user.decrement!(:coins, coins)
    else
      user.increment!(:coins, coins)
    end
  end

  def can_return_user_coins?
    return true if (!deduct? && user.coins >= coins) || deduct?
    errors.add(:base, "User Coins Not Sufficient")
  end
end
