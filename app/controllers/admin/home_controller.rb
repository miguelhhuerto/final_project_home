class Admin::HomeController < ApplicationController
  def index
    @items = filter_items
  end

  private
  def filter_items
    items = Item.where(status: :active, state: :started)
                .where('offline_at > ?', Time.now)

    items = items.where(serial_number: params[:serial_number]) if params[:serial_number].present?
    items = items.where("name ILIKE ?", "%#{params[:item_name]}%") if params[:item_name].present?
    items = items.joins(:user).where("users.email ILIKE ?", "%#{params[:email]}%") if params[:email].present?
    items = items.where(state: params[:state]) if params[:state].present?
    items = items.where("created_at >= ?", params[:start_date]) if params[:start_date].present?
    items = items.where("created_at <= ?", params[:end_date]) if params[:end_date].present?

    items.order(:created_at)
  end
end
