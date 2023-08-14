class LotteryController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :set_item, only: [:create]

    def index
        @items = Item.where(status: :active, state: :started)
        .where('offline_at > ?', Time.now)
        .order(:created_at)
        @categories = Category.all
    end

    def create
    end

    def show
        @bets = Bet.all
        @item = Item.find(params[:id])
    end

  private

  def set_item
    @item = Item.find(params[:item_id])
    puts "@item: #{@item.inspect}"
  end
end
