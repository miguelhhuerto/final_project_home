class HomeController < ApplicationController
  def index
    @banners = Banner.all
    @feedbacks = Feedback.all
    @items = Item.where(status: "active", state: "started")
    @news_tickers = NewsTicker.where(status: "active")
  end
end
