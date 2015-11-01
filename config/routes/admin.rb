namespace :admin do
  root 'dashboard#index'
  resources :articles
end