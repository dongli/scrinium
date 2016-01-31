Rails.application.routes.draw do
  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  root 'home#index'
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
  resources :users, except: [:show, :edit] do
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
  get 'users/:id/home_page' => 'users#show_home_page', as: :show_user_home_page
  get 'users/:id/(:category)' => 'users#show', as: :show_user
  get 'users/:id/edit/(:category)' => 'users#edit', as: :edit_user
  get 'follow/:followed_id' => 'relationships#follow', as: :follow_user
  get 'unfollow/:followed_id' => 'relationships#unfollow', as: :unfollow_user
  # 文章
  resources :articles, concerns: [:commentable, :collectable]
  post 'articles/upload_image' => 'articles#upload_image', as: :article_upload_image
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
  resources :nodes
  resources :topics, only: [:show, :destroy], concerns: [:commentable, :collectable]
  post 'topics/upload_image' => 'topics#upload_image', as: :topic_upload_image # TODO: 放到concerns中。
  resources :groups, except: [:show, :edit] do
    member do
      post :upload_image
    end
    resources :nodes, only: [:edit, :create, :update]
    resources :topics, only: [:new, :edit, :create, :update]
  end
  get 'groups/:id/home_page' => 'groups#show_home_page', as: :show_group_home_page
  get 'groups/:id/(:category)' => 'groups#show', as: :show_group
  get 'groups/:id/edit/(:category)' => 'groups#edit', as: :edit_group
  resources :group_options
  resources :activities

  # 控制台
  get 'dashboard' => 'dashboard#index', as: :dashboard
  DashboardController::AdminModels.each do |category|
    get "dashboard/admin/#{category}" => "dashboard#admin_#{category}", as: "admin_#{category}"
  end
end
