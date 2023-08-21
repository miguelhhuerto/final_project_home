class WinningsController < ApplicationController
    def index
        @winners = Winner.where(user_id: current_user.id)
    end
end
