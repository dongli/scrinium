Rails.application.routes.draw do
  class ActionDispatch::Routing::Mapper
    def draw(routes_name)
      instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
    end
  end

  root 'home#index'
  mount API => '/'
  mount GrapeSwaggerRails::Engine => '/apidoc' unless Rails.env.production?

  get 'news/index'
  get 'library/index'

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Concerns
  concern :commentable do
    resources :comments, except: [ :new, :show ]
    get '/comments/reply/:id' => 'comments#reply', as: :reply_comment
  end
  concern :collectable do
    get '/collect' => 'collections#collect', as: :collect
    get '/uncollect' => 'collections#uncollect', as: :uncollect
  end
  get '/collections/:id/toggle_watched' => 'collections#toggle_watched', as: :collection_toggle_watched
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
  resources :users do
    get 'mailbox/index'
    get 'mailbox/reply_message/:id' => 'mailbox#reply_message', as: :reply_message
    get 'mailbox/write_message' => 'mailbox#write_message', as: :write_message
    post 'mailbox/send_message' => 'mailbox#send_message', as: :send_message
    get 'mailbox/delete_message/:id' => 'mailbox#delete_message', as: :delete_message
    get 'mailbox/delete_notification/:id' => 'mailbox#delete_notification', as: :delete_notification
    get 'mailbox/empty_trash' => 'mailbox#empty_trash', as: :empty_trash
    get 'mailbox/restore_message/:id' => 'mailbox#restore_message', as: :restore_message
  end
  # 文章
  resources :articles, concerns: [ :commentable, :collectable ]
  get '/articles/:id/versions' => 'articles#versions', as: :article_versions
  get '/articles/:id/versions/:version_id' => 'articles#delete_version', as: :delete_version # 目前没什么用。
  # 资源
  resources :resources, concerns: [ :commentable, :collectable ]
  resources :folders
  [ :delete_files, :rename_file, :move_files, :share_files ].each do |action|
    get "#{action}/:folderable_type/:folderable_id" => "resource_board##{action}", as: action
  end
  resources :shares do
    member do
      get :back_to_top
    end
  end
  # 参考文献
  resources :publications, except: [ :index, :new, :edit, :show ]
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
  resources :groups
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
  # 后台管理
  draw :admin
end
