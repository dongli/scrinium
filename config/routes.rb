Rails.application.routes.draw do
  namespace :admin do
    DashboardManifest::DASHBOARDS.each do |dashboard_resource|
      resources dashboard_resource
    end

    root controller: DashboardManifest::ROOT_DASHBOARD, action: :index
  end

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'home#index'
  get 'news/show'
  get 'library/index'
  get 'about' => 'home#about'

  # Concerns
  concern :commentable do
    resources :comments, except: [:new, :show]
    get '/comments/reply/:id' => 'comments#reply', as: :reply_comment
  end
  get '/comments/:id/show_parent' => 'comments#show_parent', as: :show_parent_comment
  concern :collectable do
    get '/collect' => 'collections#collect', as: :collect
    get '/uncollect' => 'collections#uncollect', as: :uncollect
  end
  get '/collections/:id/view' => 'collections#view', as: :collection_view
  # 用户
  devise_for :users, path_prefix: 'd',
    controllers: {
      sessions:      'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      passwords:     'users/passwords',
      emails:        'users/emails'
    }
  resources :users, except: :edit do
    member do
      get 'show_home_page'
    end
    get 'mailbox/index'
    get 'mailbox/reply_message/:id' => 'mailbox#reply_message', as: :reply_message
    get 'mailbox/write_message' => 'mailbox#write_message', as: :write_message
    post 'mailbox/send_message' => 'mailbox#send_message', as: :send_message
    get 'mailbox/delete_message/:id' => 'mailbox#delete_message', as: :delete_message
    get 'mailbox/delete_notification/:id' => 'mailbox#delete_notification', as: :delete_notification
    get 'mailbox/empty_trash' => 'mailbox#empty_trash', as: :empty_trash
    get 'mailbox/restore_message/:id' => 'mailbox#restore_message', as: :restore_message
    get 'following' => 'relationships#following', as: :following
    get 'followers' => 'relationships#followers', as: :followers
    resources :achievements
    resources :experiences
    resources :user_options
    resources :user_quota
  end
  get '/users/:id/edit/:category' => 'users#edit', as: :edit_user
  get '/follow/:followed_id' => 'relationships#follow', as: :follow_user
  get '/unfollow/:followed_id' => 'relationships#unfollow', as: :unfollow_user
  # 文章
  resources :articles, concerns: [:commentable, :collectable]
  get '/articles/:id/versions' => 'articles#versions', as: :article_versions
  get '/articles/:id/versions/:version_id' => 'articles#delete_version', as: :delete_version # 目前没什么用。
  post 'articles/:id/upload_image' => 'articles#upload_image', as: :article_upload_image
  # 资源
  resources :resources, concerns: [:commentable, :collectable]
  resources :folders
  [:delete_files, :rename_file, :move_files, :share_files].each do |action|
    get "#{action}/:folderable_type/:folderable_id" => "resource_board##{action}", as: action
  end
  resources :shares do
    member do
      get :back_to_top
    end
  end
  # 参考文献
  resources :publications, except: [:index, :new, :edit, :show]
  resources :references
  resources :publishers
  # 资格
  resources :memberships do
    member do
      get :reject
    end
  end
  # 机构
  resources :organizations
  resources :addresses
  # 群组
  resources :topics, concerns: [:commentable, :collectable]
  resources :groups, except: :edit do
    get :feed, on: :collection
    member do
      get :members
    end
    resources :nodes
    resources :topics
  end
  get '/groups/:id/edit/:category' => 'groups#edit', as: :edit_group
  resources :group_options
  resources :activities
  resources :posts do
    member do
      get :change_sticky
    end
  end
  get '/post_to_groups' => 'posts#post_to_groups'
  # 插件
  resources :licenses
  if File.exist? "#{Rails.root}/config/engine_routes.rb"
    instance_eval File.read "#{Rails.root}/config/engine_routes.rb"
  end
end
