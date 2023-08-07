class Admin::SessionsController < Devise::SessionsController
    before_action :admin_check, only: [:create]
    def new
      super
    end
    
    # POST /clients/sign_in
    def create
      if @user && @user.admin?
        super
    else
      flash[:alert] = "You don't have permission to access this page."
      redirect_to new_user_session_path
    end
    end
  
    # DELETE /clients/sign_out
    def destroy
      super
    end

    private

    def admin_check
      @user = User.find_by_email(params[:user][:email])
    end
end

