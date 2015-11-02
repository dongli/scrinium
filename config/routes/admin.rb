namespace :admin do
  root 'dashboard#index'
  resources :articles
  resources :organizations
  resources :users
  resources :collections
  resources :comments
  resources :groups
  resources :licenses
  resources :memberships
  resources :posts
  resources :profiles
  resources :resources

end