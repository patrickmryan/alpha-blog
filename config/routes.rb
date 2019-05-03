Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pages#home'
#  get 'pages/home', to: 'pages#home'
#  get 'pages/about', to: 'pages#about'
  get 'about', to: 'pages#about'

  resources :articles

  get 'signup', to: 'users#new'

  resources :users, except: [:new]

  #    url path     ctrl     method   will look for SessionsController {plural}
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]

end
