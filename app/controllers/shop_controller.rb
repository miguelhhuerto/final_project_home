class ShopController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :order_params, only: [:create]
    before_action :set_offer, only: [:create]

    def index
        @offers = Offer.where(status: :active)
    end



    def show
        @offer = Offer.find(params[:id])
        @order = Order.new(offer_id: @offer)
        @user = current_user
    end


end
