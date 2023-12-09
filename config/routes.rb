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
  get "links/:id/daily_access_count_report" => "links#daily_access_count_report", as: :daily_access_count_report_links
  get "links/:id/access_detail_report" => "links#access_detail_report", as: :access_detail_report_links

  # Defines the root path route ("/")
  # root "posts#index"
end
