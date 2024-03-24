Rails.application.routes.draw do
  get 'web/bootstrap'
  scope '/' do
    post '/login', to: 'sessions#create'
  end
  
  resources :users, only: [:create, :show]
  resources :friendship_requests, only: [:create]
  resources :friendships, only: [:create]

  resources :pets do
    resources :posts, only: [:create, :index]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
