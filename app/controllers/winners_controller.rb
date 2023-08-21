class WinnersController < ApplicationController
    class Admin::ItemsController < ApplicationController
        before_action :set_winner, only: [:claimed, :submitted, :paid, :shipped, :delivered, :shared, :published, :remove_published]

        def claim
          if @winner.may_claim? && @winner.claim!
            flash[:notice] = "Item Claimed!"
            redirect_to user_path 
          end
        end
        
        def submit
          if @winner.may_submit? && @winner.submit!
            flash[:notice] = "Item Submitted!"
            redirect_to admin_users_path 
          end
        end

        def pay
          if @winner.may_pay? && @winner.pay!
            flash[:notice] = "Item Paid!"
            redirect_to admin_users_path 
          end
        end

        def deliver
          if @winner.may_deliver? && @winner.deliver!
            flash[:notice] = "Item Delivered!"
            redirect_to admin_users_path 
          end
        end
        
        def share
          if @winner.may_share? && @winner.share!
            flash[:notice] = "Item Shared!"
            redirect_to admin_users_path 
          end
        end

        def publish
          if @winner.may_publish? && @winner.publish!
            flash[:notice] = "Item Published!"
            redirect_to admin_users_path 
          end
        end

        def remove_publish
          if @winner.may_remove_publish? && @winner.remove_publish!
            flash[:notice] = "Removed Publish!"
            redirect_to admin_users_path 
          end
        end

        def ship
            if @winner.may_ship? && @winner.ship!
              flash[:notice] = "Item Shipped!"
              redirect_to admin_users_path 
            end
        end
        

      
        private
      
        def set_winner
          @winner = Winner.find(params[:id])
        end
end
