SampleApp::Application.routes.draw do
 








  resources :users do
    member do
      get :following, :followers, :solutions, :hints, :explanations
    end
  end
  resources :sessions,   only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :problems, only: [:show, :create]
  resources :solutions, only: [:new, :show, :create, :index]
  resources :reviews, only: [:create]
  resources :explanations, only: [:index, :show, :create, :new]
  resources :hints, only: [:create, :new, :show]
  resources :categories, only: [:index, :show, :create, :new]
  resources :online_judges, only: [:new, :show, :create, :index]
  resources :category_relations, only: [:create, :new]

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'static_pages#home'
  # match '/', to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

end
