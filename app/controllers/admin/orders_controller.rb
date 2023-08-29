class Admin::OrdersController < ApplicationController
    before_action :set_order, only: [:pay,:submit, :cancel]
    before_action :set_user, only: [:new, :create, :cancel]
    def index
        @orders = Order.all
  
    end
    
    # def new
    #   @user = User.find(params[:user_id])
    #   puts "User ID: #{params[:user_id]}, Found User: #{@user}"
    #   @order = Order.new

    # end

    # def create
    #   @user = User.find_by(username: params[:user_id])
    #   puts "Creating order..."
    #   @order = Order.new(order_params)
    
    #   if @order.save
    #     puts "Order saved successfully."
    #     redirect_to admin_users_path(@user), notice: 'Order created successfully.'
    #   else
    #     puts "Failed to save order."
    #     flash.now[:alert] = "Failed to create order: #{@order.errors.full_messages.join(', ')}"
    #     redirect_to admin_users_path(@user)
    #   end
    # end

    def pay
      if @order.may_pay? && @order.pay!
        flash[:notice] = "Order Paid!"
        redirect_to admin_orders_path 
      end
    end
    
    def submit
      if @order.may_submit? && @order.submit!
        flash[:notice] = "Order Submitted"
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

  def order_params
    params.require(:order).permit(:coins, :genre, :remarks, :user_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def set_user
    @user = User.find_by(username: params[:user_id])
  end
end
