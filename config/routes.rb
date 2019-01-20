# get die URL dadurch ensteht ein URL helper
# to: ein controller der zu eine Action hinweis

Rails.application.routes.draw do



  root 'static_pages#home'
  get  '/help', to: 'static_pages#help'
  get  '/about', to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  get  '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
   # User bekommt die REST (GET,POST,PATCH,DELETE) Methoden und bekommt somit die
   # URLS 	/users , /users/1 etc.
  resources :users
end
