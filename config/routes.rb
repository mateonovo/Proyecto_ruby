Rails.application.routes.draw do
  resources :links
  devise_for :users, :controllers => {
    registrations: 'registrations'
  }
  root "main#home"
  resources :users, only: [:index, :create, :new, :destroy, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "l/:slug" => "links#send_to_original_url", as: :send_to_original_url
  post "l/:slug" => "links#authenticate_private_link", as: :authenticate_private_link

  # Defines the root path route ("/")
  # root "posts#index"
end
