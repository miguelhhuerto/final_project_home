class LotteryController < ApplicationController
    def index
        @items = Item.where(status: :active, state: :started)
        .where('offline_at > ?', Time.now)
        .order(:created_at)
        @categories = Category.all
    end
end
