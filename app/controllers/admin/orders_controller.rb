class Admin::OrdersController < ApplicationController
    before_action :set_order, only: [:submit, :pause, :cancel]
    def index
        @orders = Order.all
    end

    def cancel
      if @order.may_cancel? && @order.cancel!
        flash[:notice] = "Order Canceled"
        redirect_to admin_orders_path 
      end
    end

   
  private

  def set_order
    @order = Order.find(params[:id])
  end

end
