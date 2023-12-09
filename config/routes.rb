Rails.application.routes.draw do
  resources :visit_infos
  resources :links
  devise_for :users
  get 'dashboard/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get 'l/:unique_token', to: 'links#redirect_to_url'

  post 'l/:unique_token', to: 'links#validate_password', as: :validate_password_link

  delete 'delete_account', to: 'users#delete_account', as: 'delete_account'

  # Defines the root path route ("/")
  root "dashboard#index"
end
