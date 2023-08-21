class WinningsController < ApplicationController
    before_action :set_winner, only: [:claim]
    def index
        @winners = Winner.where(user_id: current_user.id)
    end

    def claim
      if @winner.may_claim? && @winner.claim!
        flash[:notice] = "Item Claimed!"
        redirect_to user_path 
      end
    end

    private

    def set_winner
      @winner = Winner.find(params[:id])
    end
end
