class OrdersController < ApplicationController
    before_action :authenticate_user!, only: [:create]
    before_action :set_offer, only: [:create]

    def index 
      @orders = Order.where(offer_id: params[:offer_id])

      if params[:start_date].present? && params[:end_date].present?
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        @orders = @orders.where(created_at: start_date..end_date)
      end
    end
  
    def create
      @order = Order.new(order_params)
      @order.user = current_user
      @order.offer_id = @offer.id
  
      if @order.save
        flash[:notice] = 'Order placed successfully'
        redirect_to shop_index_path
      else
        flash.now[:alert] = 'Order creation failed'
        render 'shop/show'
      end
    end

    def submit
      if @order.may_submit? && @order.submit!
        flash[:notice] = "Order Started"
        redirect_to admin_ordes_path 
      end
    end
    
    def pause
      if @order.may_pause? && @order.pause!
        flash[:notice] = "Order Paused"
        redirect_to admin_orders_path 
      end
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
  
    def order_params
      params.require(:order).permit(:genre, :amount, :coin, :remarks)
    end
  
    def set_offer
      @offer = Offer.find(params[:order][:offer_id])
    end
end
