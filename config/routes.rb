Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'admin#labels'

  get '/index' => 'admin#index'
  get '/redirect' => 'admin#redirect'
  
  get '/callback' => 'admin#callback'
  
  get '/labels' => 'admin#labels'

  post '/users/:email_id' => 'users#routing'

  get '/users/:id' => 'users#show'

  # these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  
end
