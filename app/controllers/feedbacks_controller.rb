class FeedbacksController < ApplicationController
    before_action :set_user, only: [:create]
    before_action :feedback_params, only: [:create]

    def index
      @feedbacks = Feedback.all
    end

    def new
      @feedback = Feedback.new
    end
      
    def create
      @feedback = Feedback.new(feedback_params)
      @feedback.user_id = current_user.id
      if @feedback.save
        flash[:notice] = 'Feedback shared successfully'
        redirect_to user_winning_feedbacks(@user)
      else
        flash.now[:alert] = 'Post create failed'
        render :new, status: :unprocessable_entity
      end
    
      end

      private

  def feedback_params
    params.require(:feedback).permit(:message, :image)
  end

      
  def set_user
    @user = current_user
  end
end
