Myflix::Application.routes.draw do
  get "following_relationships/index"

  get 'ui(/:action)', controller: 'ui'

  root to: 'static#index'

  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'people', to: 'following_relationships#index'
  post '/people/:id/follow', to: 'following_relationships#create', as: 'follow'
  delete '/people/:id/unfollow', to: 'following_relationships#destroy', as: 'unfollow'

  resources :users, only: [:create, :show]
  resources :categories, only: [:index, :show]

  resources :videos, only: [:index, :show] do
    collection do
      post 'search'
    end
    resources :reviews, only: [:create, :update]
  end

  get 'my_queue', to: 'queue_items#index'
  post 'my_queue', to: 'queue_items#create'

  resources :queue_items, only: [:index, :new, :create, :destroy]
  post 'my_queue/update', to: "queue_items#update"

end
