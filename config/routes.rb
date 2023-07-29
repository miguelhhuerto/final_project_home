Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  devise_for :users
  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :users
    end
  end

  constraints(ClientDomainConstraint.new) do
    resources :posts do
      resources :comments, except: :show
    end
  end
end
