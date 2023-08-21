class Admin::HomeController < ApplicationController
  before_action :set_bets, only: [:index]
  before_action :set_users, only: [:index]
  def index
    if params[:start_date].present? && params[:end_date].present?
      start_date = Date.parse(params[:start_date])
      end_date = Date.parse(params[:end_date])
      @items = @items.where(created_at: start_date..end_date)
    end
    
  end

  private

  def set_bets
    @bets = Bet.all
    @bets = @bets.where(serial_number: params[:serial_number]) if params[:serial_number].present?
  end

  def set_users
    @users = User.all
    @users = @users.where(email: params[:email]) if params[:email].present?
    @users = @users.where(state: params[:state]) if params[:state].present?
    @users = @users.where("created_at >= ?", params[:start_date]) if params[:start_date].present?
    @users = @users.where("created_at <= ?", params[:end_date]) if params[:end_date].present?

  end
end
