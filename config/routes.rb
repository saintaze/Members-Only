Rails.application.routes.draw do
  root                "static_pages#home"

  get '/contact', to: 'static_pages#contact'
  get '/about',   to: 'static_pages#about'

  get '/signup',  to: 'users#new'

  resources :users, only: [:create]
  resources :posts, only: [:index, :new, :create]
end
