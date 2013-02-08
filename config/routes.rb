Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  root to: 'static#index'

  resources :users, only: [:create]
  resources :categories, only: [:index, :show]

  resources :videos, only: [:index, :show] do
    collection do
      post 'search'
    end
    resources :reviews, only: [:create]
  end

  get 'my_queue', to: 'queue_items#index'
  post 'my_queue', to: 'queue_items#create'
  resources :queue_items, only: [:index, :new, :create, :destroy]

end
