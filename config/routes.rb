Rails.application.routes.draw do
  resources :properties

  resources :skills do |skill|
    resources :users
  end

  resources :interests

  resources :users do |user|
    resources :interests
    resources :skills
  end

  get  'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
