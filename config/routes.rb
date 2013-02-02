Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
  resources :videos, only: [:index, :show] do
    collection do
      post 'search'
    end
  end
end
