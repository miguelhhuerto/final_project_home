class Admin::ItemsController < ApplicationController
  before_action :set_item, only: [:start, :pause, :end, :cancel]
  def index
    @items=Item.all
  end
  
  def new;
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = 'Post created successfully'
      redirect_to admin_items_path
    else
      flash.now[:alert] = 'Post create failed'
      render :new, status: :unprocessable_entity
    end

  end
  
  def show; end

  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    if @item.update(item_params)
      flash[:notice] = 'Item updated successfully'
      redirect_to admin_items_path
    else
      flash.now[:alert] = 'Item update failed'
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    if items_with_bet.empty?
      @item.destroy
      flash[:notice] = 'Item deleted successfully'
    else
      flash[:alert] = 'Selected Item cannot be deleted.'
    end
    redirect_to admin_items_path
  end

  def start
    if @item.may_start? && @item.start!
      flash[:notice] = "Item Started"
      redirect_to admin_items_path 
    end
  end
  
  def pause
    if @item.may_pause? && @item.pause!
      flash[:notice] = "Item Paused"
      redirect_to admin_items_path 
    end
  end
  
  def end
    if @item.may_end? && @item.end!
      flash[:notice] = "Item Ended"
      redirect_to admin_items_path 
    end
  end

  def cancel
    if @item.may_cancel? && @item.cancel!
      flash[:notice] = "Item Canceled"
      redirect_to admin_items_path 
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :name, :quantity, :batch_count, :minimum_bets, :online_at, :offline_at, :start_at, :status, :state, category_ids:[])
  end
end
