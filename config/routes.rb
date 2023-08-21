Rails.application.routes.draw do
  get 'categories/index'
  get 'categories/new'
  get 'categories/edit'

  devise_for :users, controllers: { registrations: 'users/registrations' }
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
      resources :home
      resources :users
      resources :offers
      resources :items do
        member do
          patch :start
          patch :pause
          patch :end
          patch :cancel
        end      
      end

      resources :winners do    
        member do
          patch :submit
          patch :pay
          patch :ship
          patch :deliver
          patch :publish
          patch :remove_publish
        end
      end
      resources :orders do
        member do
          patch :pay
          patch :cancel
        end
      end

      resources :categories, except: :show
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
    resources :shop, only: [:index, :show]
    resources :orders, only: [:create]
    
    
    resources :lottery, only: [:index, :show, :create] do
      resources :bets, only: [:create]
    end
    resource :user do
      resources :addresses, except: :show
      resources :lottery_history, only: [:index]
      resources :order_history, only: [:index]
      resources :winnings, only: [:index] do
        member do
          patch :claim
        end
      end
      resources :children_members, only: [:index]
      resources :invite, :only => [:index]
      collection do
        get :sign_up
      end
    end
  end
end
