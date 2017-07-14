Rails.application.routes.draw do
  resources :properties

  resources :skills do
    collection do 
      get 'search_users'
    end
    resources :users
  end

  resources :interests

  resources :users do 
    member do
      get 'connect_with/:mentor_id' => 'users#connect_with'
      get 'mentors'
      get 'mentees'
    end
    resources :interests
    resources :skills
  end

  get  'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
