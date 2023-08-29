class Admin::OffersController < ApplicationController
  before_action :set_offer, only: [:edit, :update, :destroy]
  before_action :offer_params, only: [:create]
  
      def index
        @offers=Offer.all
      end
      
      def new;
        @offer = Offer.new
        @offers = Offer.all
      
        if params[:genre].present?
          @offers = @offers.where(genre: params[:genre])
        end
      
        if params[:status].present?
          @offers = @offers.where(status: params[:status])
        end
      end
      
      def create
        @offer = Offer.new(offer_params)
        if @offer.save
          flash[:notice] = 'Offer created successfully'
          redirect_to admin_offers_path
        else
          flash.now[:alert] = 'Offer create failed'
          render :new, status: :unprocessable_entity
        end
      end
      
      def show
        @offer = Offer.find(params[:id])
      end
  
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
        @offer = Offer.find(params[:id])
        @offer.destroy
        flash[:notice] = 'Offer deleted successfully'
        redirect_to admin_offers_path
      end

  
      private
  
      def set_offer
        @offer = Offer.find(params[:offer_id])
        puts "Offer ID: #{params[:offer_id]}"
        puts "Offer: #{@offer.inspect}"
      end
  
      def offer_params
        params.require(:offer).permit(:image, :name, :genre, :amount, :coin, :status)
      end
  end
  