class Admin::UsersController < ApplicationController



  def index
    @users = User
  end


end
