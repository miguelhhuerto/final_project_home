class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:index]
  def index;
  end

  private

  def set_user
    @users = User.where(role: 'client')
  end

end
