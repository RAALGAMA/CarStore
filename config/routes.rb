Rails.application.routes.draw do
  get 'about/about'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :manufacturers, only: %i[index show]
  resources :cart, only: %i[create destroy]
  resources :abouts
  resources :cars, only: [:show, :index] do
    collection do
      get :search
    end
  end
  #Rails.application.routes.draw do
  #  get '/about', to: 'about#about'
  #end

  #scope 'checkout' do
  #  post 'create', to: 'checkout#create', as: 'checkout_create'
  #  get 'success', to: 'checkout#success', as: 'checkout_success'
  #  get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  #end

  root to: 'cars#index'
end
