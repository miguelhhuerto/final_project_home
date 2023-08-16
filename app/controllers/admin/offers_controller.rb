class Admin::OffersController < ApplicationController
    
      def index
        @offers=Offer.all
      end
      
      def new;
        @offer = Offer.new

        if params[:genre].present?
            @offers = @offers.where(genre: params[:genre])
          end
      
        if params[:status].present?
          @offers = @offers.where(status: params[:status])
        end
      end
      
    #   def create
    #     @item = Item.new(item_params)
    #     if @item.save
    #       flash[:notice] = 'Post created successfully'
    #       redirect_to admin_items_path
    #     else
    #       flash.now[:alert] = 'Post create failed'
    #       render :new, status: :unprocessable_entity
    #     end
    #   end
      
      def show; end
  
      def edit
        @offer = Offer.find(params[:id])
      end
      
      def update
        if @offer.update(offer_params)
          flash[:notice] = 'Offer updated successfully'
          redirect_to admin_offers_path
        else
          flash.now[:alert] = 'Offer update failed'
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
        redirect_to admin_offers_path
      end

  
      private
  
      def set_item
        @item = Item.find(params[:id])
      end
  
      def item_params
        params.require(:item).permit(:image, :name, :quantity, :batch_count, :minimum_bets, :online_at, :offline_at, :start_at, :status, :state, category_ids:[])
      end
  end
  