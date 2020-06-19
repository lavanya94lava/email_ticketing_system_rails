Rails.application.routes.draw do

  resources :emails
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'admin#index'

  get '/redirect' => 'admin#redirect'
  
  get '/callback' => 'admin#callback'
  
  get '/labels' => 'admin#labels'


  # these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end
