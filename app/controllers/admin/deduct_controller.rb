class Admin::DeductController < ApplicationController
    def new;
        @order = Order.new
        @admin_balance_view = true
    end

    def create
        @order = Order.new(order_params)
        if @order.save
          if @order.may_submit?
            @order.submit!
            if @order.may_pay?
                @order.pay!
            else
                @order.cancel!
            end
          end
        end 
          @order.user.decrement!(:coins, @order.coins )
          flash[:notice] = 'Order created successfully'
          redirect_to new_admin_user_orders_increase_path(user.id)
        else
          flash.now[:alert] = 'Order create failed'
          render :new, status: :unprocessable_entity
    end
end
