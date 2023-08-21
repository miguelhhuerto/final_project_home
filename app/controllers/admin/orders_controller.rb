class Admin::OrdersController < ApplicationController
    before_action :set_order, only: [:submit, :pause, :cancel]
    def index
        @orders = Order.all
    end

   
  private

  def set_order
    @order = Order.find(params[:id])
  end

end
