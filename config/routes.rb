SampleApp::Application.routes.draw do
 








  # get "unlocks/create"

  # get "available_times/show"

  resources :users do
    member do
      get :following, :followers, :solutions, :hints, :explanations
    end
  end

  resources :problems do
    member do
      get :solutions, :hints, :explanations, :categories
    end
  end

  resources :sessions,   only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  resources :problems, only: [:show, :create, :index]
  
  resources :reviews, only: [:create]
  resources :explanations, only: [:index, :show, :create, :new, :destroy, :edit, :update]
  resources :hints, only: [:create, :new, :show, :destroy, :edit, :update]
  resources :categories, only: [:index, :show, :create, :new]
  resources :online_judges, only: [:new, :show, :create, :index]
  resources :category_relations, only: [:create, :new, :destroy]
  resources :languages, only: [:index]
  resources :solutions, only: [:show, :new, :create, :index, :destroy, :edit, :update]

  resources :unlocks, only: [:create]
  # resources :public_links, only: [:show]
  
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete

  root to: 'static_pages#home'
  # match '/', to: 'static_pages#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/hall_of_fame', to: 'static_pages#hall_of_fame'
  match '/chrome_extension', to: 'static_pages#chrome_extension'
  match '/public_links', to: 'public_links#show'

  # match '/state', to: 'available_times#show'

end
