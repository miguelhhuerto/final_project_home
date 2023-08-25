class BetsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @item = Item.find(params[:item_id]) 
    coins_to_bet = params[:coins].to_i
    if current_user.coins >= coins_to_bet
      coins_to_bet.times do
        bet = Bet.create(user: current_user, item: @item)
        if bet.save
          bet.item.increment!(:number_count, 1)
          Rails.logger.info "Bet created: #{bet.inspect}"
          number_count = format('%04d',  bet.item.number_count)
    
          formatted_date = Time.current.strftime('%y%m%d')
          item_id = @item.id
          batch_count = @item.batch_count
    
          serial_number = "#{formatted_date}-#{item_id}-#{batch_count}-#{number_count}"
          bet.update(serial_number: serial_number)
        else
          Rails.logger.error "Bet creation failed: #{bet.errors.full_messages}"
          redirect_to lottery_index_path, alert: "Bet creation failed: #{bet.errors.full_messages.to_sentence}"
          return
        end


      end
      current_user.decrement!(:coins, coins_to_bet)
      current_user.increment!(:coins_used, coins_to_bet)
      redirect_to lottery_index_path, notice: "#{coins_to_bet} bets placed successfully."
    else
      redirect_to lottery_index_path, alert: "Insufficient coins"
    end
  end
end