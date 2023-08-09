class Admin::ItemsController < ApplicationController
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

    def edit; end
    
    def update
      if @post.update(item_params)
        flash[:notice] = 'Item updated successfully'
        redirect_to admin_items_path
      else
        flash.now[:alert] = 'Item update failed'
        render :edit, status: :unprocessable_entity
      end
    end
    
    def destroy
      @item.destroy
      flash[:notice] = 'Item destroyed successfully'
      redirect_to admin_items_path
    end

    private

    def set_item
      @item = Items.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:image, :name, :quantity, :batch_count, :minimum_bets, :online_at, :offline_at, :start_at, :status, :state, category_ids:[])
    end
end
