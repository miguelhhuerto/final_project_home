class Admin::DeductController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @order = Order.new
  end

  def create
    @user = User.find(params[:user_id])
    @order = @user.orders.build(order_params)
    @order.genre = :deduct
    if @order.save
      @order.pay!
      redirect_to admin_users_path, notice: 'Coins deducted successfully!'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:coins, :remarks)
  end
end