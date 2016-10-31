Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'homes#show'

  resources :users, only: [:new, :create]
  resources :links, only: [:index, :create, :update]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/read', to: 'links#read'
  get '/unread', to: 'links#unread'
end
