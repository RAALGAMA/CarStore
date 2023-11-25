Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  #devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :manufacturers, only: %i[index show]
  resources :cars, only: :show do
    collection do
      get :search
    end
  end

  root to: 'manufacturers#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
