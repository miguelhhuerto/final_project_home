class Client::SessionsController < Devise::SessionsController
    def new
        super
      end
    
      # POST /clients/sign_in
      def create
        super
      end
    
      # DELETE /clients/sign_out
      def destroy
        super
      end
end
