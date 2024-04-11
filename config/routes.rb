Rails.application.routes.draw do
  get 'web/bootstrap'
  scope '/' do
    post '/login', to: 'sessions#create'
  end
  
  # sends put request w/ post id we want to like
  resources :like do
    put '/post/:id/like' to: 'posts#like', as: 'like'
  end

  resources :playdates do
    post 'join', to: 'playdates#join'
    
    # localhost:3000/playdates/1/leave
    delete 'leave', to: 'playdates#leave'
  end
  
  scope :profiles do
    get ':username', to: "profiles#show"
  end

  resources :users, only: [:create, :show]
  resources :friendship_requests, only: [:create]
  resources :friendships, only: [:create]

 # on a specific resource so required id/specific posts
  resources :pets do
    get 'posts', to: "pets#posts_index", on: :member
  end

  resources :posts

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
