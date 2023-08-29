class WinningsAddressesController < ApplicationController
    def index
        @addresses = Address.where(user_id: current_user.id)
    end
end
