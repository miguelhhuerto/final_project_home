Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'admin/sessions', registrations: 'users/registrations' }
  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json } do
        resources :provinces, only: :index, defaults: { format: :json }
      end    
      resources :provinces, only: %i[index show], defaults: { format: :json } do
        resources :cities, only: :index, defaults: { format: :json }
      end
      resources :cities, only: %i[index show], defaults: { format: :json } do
        resources :barangays, only: :index, defaults: { format: :json }
      end
      resources :barangays, only: %i[index show], defaults: { format: :json }
    end
  end


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
    resource :user do
      resources :addresses, except: :show
      resources :invite, :only => [:index]
      collection do
        get :sign_up
      end
    end
  end
end
