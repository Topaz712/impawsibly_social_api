Rails.application.routes.draw do
  get 'web/bootstrap'
  scope '/' do
    post '/login', to: 'sessions#create'
  end
  
  resources :users, only: [:create, :show]
  resources :friendship_requests, only: [:create]
  resources :friendships, only: [:create]

 # on a specific resource so required id/specific posts
  resources :pets do
    get 'posts', to: "pets#posts_index", on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
