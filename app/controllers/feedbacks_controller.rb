class FeedbacksController < ApplicationController
    before_action :set_user, only: [:create]

    def index
      @feedbacks = Feedback.all
    end

    def new
        @feedback = Feedback.new
    end
      
    def create
      @feedback = Feedback.new(feedback_params)
      if @feedback.save
        flash[:notice] = 'Feedback shared successfully'
        redirect_to user_winnings_path(@user)
      else
        flash.now[:alert] = 'Post create failed'
        render :new, status: :unprocessable_entity
      end
    
      end

      private

      
  def set_user
    @user = current_user
  end
end
