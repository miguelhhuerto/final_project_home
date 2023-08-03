class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = 'Updated successfully'
      redirect_to edit_user_path
      puts 'hi'
    else
      puts @user.errors.full_messages
      puts 'hi'
      render :edit
    end
  end

  private

  def find_user
    @user = current_user
    @user.create_profile unless @user.profile
  end

  def user_params
    params.require(:user).permit(profile_attributes: [:username, :phone_number, :password, :image] )
  end
end
