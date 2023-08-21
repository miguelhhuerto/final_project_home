class LotteryHistoryController < ApplicationController
    def index
        @bets = Bet.where(user_id: current_user.id)
    end
end
