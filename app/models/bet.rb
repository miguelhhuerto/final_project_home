class Bet < ApplicationRecord
    belongs_to :user
    belongs_to :item
        
    after_create :subtract_coin
    after_create :assign_serial_number

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
            user.increment(:coins, 1)
            user.save
          end
        end
      end

    
    private

 
    def assign_serial_number
        number_count = format('%04d', item.batch_count + 1)
        formatted_date = Time.current.strftime('%y%m%d')
        item_id = item.id
        batch_count = item.batch_count

        serial_number = "#{formatted_date}-#{item_id}-#{batch_count}-#{number_count}"
        self.update(serial_number: serial_number)
    end
    
    def subtract_coin
      user.decrement(:coins)
      user.save
    end
end
