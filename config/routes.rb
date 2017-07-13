Rails.application.routes.draw do
  resources :properties
  resources :skills
  resources :interests
  resources :users
  get  'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
