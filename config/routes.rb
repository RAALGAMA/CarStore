Rails.application.routes.draw do
  get 'about/about'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :manufacturers, only: %i[index show]
  resources :cars, only: [:show, :index] do
    collection do
      get :search
    end
  end
  Rails.application.routes.draw do
    get '/about', to: 'about#about'
  end

  root to: 'manufacturers#index'
end
