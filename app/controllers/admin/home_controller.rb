class Admin::HomeController < ApplicationController
  before_action :set_bets, only: [:index]
  before_action :set_users, only: [:index]
  def index
    @bets
    @users
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
