Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :displays, param: :host_uuid do
    member do
      get 'watch'
      get 'setup'
    end
  end

  root to: 'displays#index'
end
