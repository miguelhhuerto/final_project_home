class Bet < ApplicationRecord
    belongs_to :user
    belongs_to :item
    has_many :winners
    after_create :assign_batch

    include AASM
    
    aasm column: :state do
        state :betting, initial: true
        state :won
        state :lost
        state :cancelled
    
        event :win do
          transitions from: :betting, to: :won
        end
    
        event :lose do
          transitions from: :betting, to: :lost
        end
    
        event :cancel do
          transitions from: :betting, to: :cancelled
          after do
            user.increment!(:coins, 1)
            user.decrement!(:coins_used, 1)
            user.save
          end
        end
      end

    
    private

    def assign_batch
      self.batch_count = item.batch_count
    end
end
