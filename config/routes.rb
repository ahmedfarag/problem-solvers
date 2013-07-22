SampleApp::Application.routes.draw do
  get "comments/show"

  get "comments/new"

  get "comments/create"

  get "comments/destroy"

  get "comments/edit"

  get "comments/update"



  get "languages/index"

  get "languages/new"

  get "languages/create"

  get "languages/destroy"

  get "online_judges/index"

  get "online_judges/show"

  get "online_judges/new"

  get "online_judges/create"

  get "online_judges/destroy"

  

  get "hints/new"

  get "hints/create"

  get "hints/destroy"

  get "hints/edit"

  get "hints/update"

  get "solutions/index"




  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :sessions,   only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :problems, only: [:show]
  resources :solutions, only: [:new, :show, :create]
  resources :reviews, only: [:create]
  resources :explanations, only: [:index, :show, :create, :new]
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'static_pages#home'
  # match '/', to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

end
