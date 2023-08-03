Rails.application.routes.draw do
  devise_for :users



  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :users
    end

    devise_scope :user do
      authenticated :user do
        root 'admin/home#index', as: :authenticated_root
      end
  
      unauthenticated do
        root 'admin/sessions#new', as: :unauthenticated_root
      end
    end
  end

  constraints(ClientDomainConstraint.new) do
        root 'home#index'
        resources :home
        resource :user
    end
end
