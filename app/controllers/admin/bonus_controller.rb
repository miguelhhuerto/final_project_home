class Admin::BonusController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @order = Order.new
  end

  def create
    @user = User.find(params[:user_id])
    @order = @user.orders.build(order_params)
    @order.genre = :bonus
    if @order.save
      @order.pay!
      redirect_to admin_users_path, notice: 'Bonus Added successfully!'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:coins, :remarks)
  end
end