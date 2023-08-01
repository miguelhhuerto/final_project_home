Rails.application.routes.draw do
  devise_for :users

  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :users
    end

    devise_scope :user do
      authenticated :user do
        root 'home#index', as: :authenticated_root
      end
  
      unauthenticated do
        root 'admin/sessions#new', as: :unauthenticated_root
      end
    end
  end

  constraints(ClientDomainConstraint.new) do
    devise_scope :user do
      authenticated :user do
        root 'home#index', as: :client_authenticated_root
      end

      unauthenticated do
        root 'client/sessions#new', as: :client_unauthenticated_root
      end
    end
  end
end
