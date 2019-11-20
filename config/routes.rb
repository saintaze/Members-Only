Rails.application.routes.draw do

  root                           "static_pages#home"

  get       '/contact',      to: 'static_pages#contact'
  get       '/about',        to: 'static_pages#about'

  get       '/signup',       to: 'users#new'
  get       '/login',        to: 'sessions#new'
  post      '/login',        to: 'sessions#create'
  delete    '/logout',       to: 'sessions#destroy' #guard

  resources :users,          only: [:create]
  resources :posts,          only: [:index, :new, :create]

end
