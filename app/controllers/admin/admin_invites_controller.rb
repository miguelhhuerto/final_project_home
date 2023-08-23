class Admin::AdminInvitesController < ApplicationController
    def index 
      if params[:parent_id].present?
        parent_email = params[:parent_id]
        @users = User.where(parent_email: parent_email)
      else
        @users = User.where.not(parent_id: nil)
      end
    end
end
