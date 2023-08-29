class WinningsController < ApplicationController
    before_action :set_winner, only: [:edit,:update,:claim, :share]
    before_action :winner_params, only: [:update]

    def index
        @winners = Winner.where(user_id: current_user.id)
    end

    def new
      @user = current_user
      @winner = Winner.new
    end

    def create
      @user = current_user
      @winner = Winner.new(winner_params)
    end

    def edit
      @user = current_user
      @winner = Winner.find(params[:id])
    end
  
    def update
      @user = current_user
      @winner = Winner.find(params[:id])
      puts "Address ID parameter: #{params[:winner][:address_id]}"
      if @winner.update(winner_params)
        @winner.claim!
        flash[:notice] = 'Item updated successfully'
        redirect_to user_winnings_path
      else
        flash[:alert] = 'Item update failed'
        @error_messages = @winner.errors.full_messages
        render :edit
      end
    end

    def claim
      @user = current_user
      if @winner.may_claim?
        if @user.addresses.count = 0
          redirect_to new_user_address_path
        else
          redirect_to edit_user_winning_path(@winner)
          flash[:notice] = "Item Claimed!"
        end
      end
    end

    def share
      if @winner.may_share? && @winner.share
        redirect_to new_user_winning_feedback_path(@winner)
      end
    end

    private

    def set_winner
      @winner = Winner.find(params[:id])
    end

    def winner_params
      params.require(:winner).permit(:address_id)
    end

end
