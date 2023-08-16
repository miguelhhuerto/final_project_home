class ShopController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :set_item, only: [:create]

    def index
        @offers = Offer.where(status: :active)
    end

    def create
    end

    def show
        @bets = Bet.all
        @offer = Offer.find(params[:id])
    end

  private

  def set_item
    @item = Item.find(params[:item_id])
    puts "@item: #{@item.inspect}"
  end
end
