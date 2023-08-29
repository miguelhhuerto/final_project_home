class Admin::NewsTickersController < ApplicationController
    def index
      @news_tickers = NewsTicker.all

    end

    def new
      @news_ticker = NewsTicker.new(admin_id: current_user.id)
    end

    def create
      @news_ticker = NewsTicker.new(news_ticker_params.merge(admin_id: current_user.id))
      if @news_ticker.save
        flash[:notice] = 'News created successfully'
        redirect_to admin_news_tickers_path
      else
        flash.now[:alert] = 'News create failed'
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @news_ticker = NewsTicker.find(params[:id])
    end
      
    def update
      if @news_ticker.update(news_ticker_params)
        flash[:notice] = 'News updated successfully'
        redirect_to admin_news_tickers_path
      else
        flash.now[:alert] = 'News update failed'
        render :edit, status: :unprocessable_entity
      end
    end
      
    def destroy
      @news_ticker = NewsTicker.find(params[:id])
      @news_ticker.destroy
      flash[:notice] = 'News deleted successfully'
      redirect_to admin_news_tickers_path
    end

  private
  
  def news_ticker_params
    params.require(:news_ticker).permit(:content, :status, :admin_id)
  end

end