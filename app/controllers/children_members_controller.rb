class ChildrenMembersController < ApplicationController
  def index
    @users = User.where(parent_id: current_user.id)
  end  
end
