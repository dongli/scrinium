Rails.application.routes.draw do
  mount API => '/'
  mathjax 'mathjax'

  get 'home/index'
  get 'researches/index'
  get 'dashboard/index'

  devise_for :users, path_prefix: 'd', controllers: { registrations: 'registrations' }
  concern :commentable do
    resources :comments, except: [ :new, :show ]
    get '/comments/reply/:id' => 'comments#reply', as: :reply_comment
  end
  resources :users do
    resources :articles, concerns: :commentable
    get '/articles/:id/versions' => 'articles#versions', as: :article_versions
    get '/articles/:id/versions/:version_id' => 'articles#delete_version', as: :delete_version
    get 'mailbox/inbox' => 'mailbox#inbox', as: :mailbox_inbox
    get 'mailbox/sentbox' => 'mailbox#sentbox', as: :mailbox_sentbox
    get 'mailbox/trash' => 'mailbox#trash', as: :mailbox_trash
  end
  resources :groups
  resources :organizations
  resources :organizationships

  root 'home#index'

end
