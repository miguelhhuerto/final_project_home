class Admin::BannersController < ApplicationController
    def index
        @banners = Banner.all
  
      end
  
      def new
        @banner = Banner.new
      end
  
      def create
        @banner = Banner.new(banner_params)
        if @banner.save
          flash[:notice] = 'Banner created successfully'
          redirect_to admin_banners_path
        else
          flash.now[:alert] = 'Banner create failed'
          render :new, status: :unprocessable_entity
        end
      end
  
      def edit
        @banner = Banner.find(params[:id])
      end
        
      def update
        if @banner.update(banner_params)
          flash[:notice] = 'Banner updated successfully'
          redirect_to admin_banners_path
        else
          flash.now[:alert] = 'Banner update failed'
          render :edit, status: :unprocessable_entity
        end
      end
        
      def destroy
        @banner = Banner.find(params[:id])
        @banner.destroy
        flash[:notice] = 'Banner successfully'
        redirect_to admin_banners_path
      end

    private
    
    def banner_params
      params.require(:banner).permit(:preview, :status, :online_at, :offline_at)
    end
  
end
