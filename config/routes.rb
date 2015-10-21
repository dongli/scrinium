Rails.application.routes.draw do
  mount API => '/'
  mathjax 'mathjax'

  get 'home/index'
  get 'researches/index'
  get 'dashboard/index'

  root 'home#index'

  # Concerns -------------------------------------------------------------------
  concern :commentable do
    resources :comments, except: [ :new, :show ]
    get '/comments/reply/:id' => 'comments#reply', as: :reply_comment
  end
  concern :collectable do
    get '/collect' => 'collections#collect', as: :collect
    get '/uncollect' => 'collections#uncollect', as: :uncollect
  end
  concern :resourceable do
    resources :resources, concerns: [ :commentable, :collectable ]
  end
  get '/collections/:id/toggle_watched' => 'collections#toggle_watched', as: :collection_toggle_watched
  get '/collections/:id/view' => 'collections#view', as: :collection_view
  # User -----------------------------------------------------------------------
  devise_for :users, path_prefix: 'd',
    controllers: {
      sessions:      'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      passwords:     'users/passwords',
      emails:        'users/emails'
    }
  get '/users/:id/change_current_organization' => 'users#change_current_organization', as: :change_current_organization
  resources :users, concerns: [ :resourceable ] do
    get 'mailbox/index'
    get 'mailbox/reply_message/:id' => 'mailbox#reply_message', as: :reply_message
    get 'mailbox/write_message' => 'mailbox#write_message', as: :write_message
    post 'mailbox/send_message' => 'mailbox#send_message', as: :send_message
    get 'mailbox/delete_message/:id' => 'mailbox#delete_message', as: :delete_message
    get 'mailbox/delete_notification/:id' => 'mailbox#delete_notification', as: :delete_notification
    get 'mailbox/empty_trash' => 'mailbox#empty_trash', as: :empty_trash
    get 'mailbox/restore_message/:id' => 'mailbox#restore_message', as: :restore_message
  end
  # Article --------------------------------------------------------------------
  resources :articles, concerns: [ :commentable, :collectable ]
  get '/articles/:id/versions' => 'articles#versions', as: :article_versions
  get '/articles/:id/versions/:version_id' => 'articles#delete_version', as: :delete_version
  # Resource -------------------------------------------------------------------
  resources :resources, concerns: [ :commentable, :collectable ]
  # Reference ------------------------------------------------------------------
  resources :publications, except: [ :index, :new, :edit, :show ]
  resources :references
  resources :journals
  # Membership -----------------------------------------------------------------
  resources :memberships
  # Organization ---------------------------------------------------------------
  resources :organizations
  resources :addresses
  # Group ----------------------------------------------------------------------
  resources :groups
  # Engines --------------------------------------------------------------------
  resources :licenses
  if File.exist? "#{Rails.root}/config/engine_routes.rb"
    instance_eval File.read "#{Rails.root}/config/engine_routes.rb"
  end
end
