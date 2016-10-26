Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :attractions

  root 'welcome#index' 
  
  match '/signup',  to: 'users#new',        via: 'get' 
  match '/signin',  to: 'sessions#new',     via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
end
