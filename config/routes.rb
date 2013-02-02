Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create', as: 'login'

  resources :videos, only: [:index, :show] do
    collection do
      post 'search'
    end
  end

  root to: 'static#front'
end
