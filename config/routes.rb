Rails.application.routes.draw do

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'admin#labels'

  get '/index' => 'admin#index'
  get '/redirect' => 'admin#redirect'
  
  get '/callback' => 'admin#callback'
  
  get '/labels' => 'admin#labels'

  #this route is used for post the emails into the user
  post '/emails/:id/users' => 'users#routing'

  # this route is used when you reply to an email
  post '/emails/reply/:id' => 'emails#reply'

  #this renders the view of the work of an employee
  get '/users/:id' => 'users#show'

  #this route renders the details of an employee
  get '/user/:id' => 'users#view'

  # this route is used for deleting an employee

  delete '/user/:id' => 'users#destroy'

  # this route shows all the users
  get '/usersAll/index' => 'users#index'


  # these routes are for showing users a login form, logging them in, and logging them out.
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  
end
