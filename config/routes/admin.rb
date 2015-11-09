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
  if File.exist? "#{Rails.root}/config/engine_routes.rb"
    instance_eval File.read "#{Rails.root}/config/engine_routes.rb"
  end

end