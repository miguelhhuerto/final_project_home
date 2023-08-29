class Admin::WinnersController < ApplicationController
  before_action :set_winner, only: [:claim, :submit, :pay, :ship, :deliver, :share, :publish, :remove_publish]
  before_action :set_users, only: [:index]
  before_action :winner_params, only: [:create]

  def index
    @winners = Winner.all
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @winners = @winners.where(created_at: start_date..end_date)
    end
  end

  def new
    @user = current_user
    @winner = Winner.new
  end

  def create
    @user = current_user
    @winner = Winner.new(winner_params)
  end


  def edit
    @user = current_user
    @winner = Winner.find(params[:id])
  end

  def update
    @winner = Winner.find(params[:id])
    if @winner.update(winner_params)
    else
      render :edit
    end
  end
  
  def claim
    if @winner.may_claim? && @winner.claim!
      flash[:notice] = "Item Claimed!"
      redirect_to admin_winners_path 
    end
  end
  
  def submit
    if @winner.may_submit? && @winner.submit!
      flash[:notice] = "Item Submitted!"
      redirect_to admin_winners_path
    end
  end

  def pay
    if @winner.may_pay?
      @winner.pay!
      @winner.update(admin_id: current_user)
      @winner.update(paid_at: Time.now)
      flash[:notice] = "Item Paid!"
      redirect_to admin_winners_path
    end
  end

  def deliver
    if @winner.may_deliver? && @winner.deliver!
      flash[:notice] = "Item Delivered!"
      redirect_to admin_winners_path 
    end
  end
  


  def publish
    if @winner.may_publish? && @winner.publish!
      flash[:notice] = "Item Published!"
      redirect_to admin_winners_path
    end
  end

  def remove_publish
    if @winner.may_remove_publish? && @winner.remove_publish!
      flash[:notice] = "Removed Publish!"
      redirect_to admin_winners_path
    end
  end

  def ship
      if @winner.may_ship? && @winner.ship!
        flash[:notice] = "Item Shipped!"
        redirect_to admin_winners_path 
      end
  end
  


  private

  def winnner_params
    params.require(:winner).permit(:bet_id, :user_id, :item_id, :item_batch_count ,:price) 
  end

  def set_winner
    @winner = Winner.find(params[:id])
  end

  def set_users
      @users = User.all
      @users = @users.where(email: params[:email]) if params[:email].present?
      @users = @users.where(state: params[:state]) if params[:state].present?
      @users = @users.where("created_at >= ?", params[:start_date]) if params[:start_date].present?
      @users = @users.where("created_at <= ?", params[:end_date]) if params[:end_date].present?
  end
end
