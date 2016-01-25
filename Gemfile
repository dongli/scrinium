if ENV['USE_OFFICIAL_GEM_SOURCE']
  source 'https://rubygems.org'
else
  source 'https://ruby.taobao.org'
end

gem 'rails', '4.2.4'

# 服务器部署
gem 'unicorn'
gem 'thin'

# 数据库
gem 'pg'
gem 'redis-rails'
gem 'redis-namespace'

# 视图和JavaScript
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'

# 用户验证与权限设置
gem 'devise'
gem 'pundit'

# 异步
gem "devise-async"
gem 'sidekiq'
gem 'sinatra', '>= 1.4.6', :require => nil

# UI
gem 'bootstrap-sass'
gem 'jasny-bootstrap-rails'
gem 'country_select'
gem 'font-awesome-rails'
gem 'bootstrap-datepicker-rails'
gem 'i18n-js', '>= 3.0.0.rc11'
gem 'momentjs-rails'
gem 'jstree-rails-4'
gem 'geo_pattern'
# ActiveRecord model/data translation.
gem 'globalize', '~> 5.0.0'

# API
gem 'grape'
gem 'jbuilder', '~> 2.0'
gem 'grape-kaminari'
gem 'active_model_serializers'
gem 'grape-active_model_serializers'
gem 'rack-cors', require: 'rack/cors'
gem 'grape-swagger'
gem 'grape-swagger-rails'

# 文件上传
gem 'carrierwave'
gem 'mini_magick'
gem 'carrierwave-qiniu', '0.1.8'
gem 'file_validators'
gem 'remotipart'

# 编辑器
gem "wysiwyg-rails", "2.0.0.pre.rc.3"

# 全局设定
gem 'settingslogic'

# 其它
gem 'simple_form'
gem 'paper_trail', '~> 4.0.0'
gem 'closure_tree'
gem 'acts-as-taggable-on', '~> 3.4'
gem 'mailboxer'
gem 'message_bus'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'lograge'
gem 'enumerize'
gem 'inherited_resources'
gem 'acts_as_tenant'
gem 'public_activity'
gem 'ffaker', require: false

# 搜索
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'ransack'

group :development, :test do
  gem 'quiet_assets'
  gem 'byebug'
  gem 'bullet'
  gem 'spring'
  gem 'annotate'
  gem 'rack-livereload'
  gem 'guard-livereload'

  # 部署
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rails'
  gem 'capistrano-scm-copy'
  gem 'net-ssh', '~> 2.8.0'
  gem 'capistrano-passenger'
  gem 'capistrano-sidekiq'

  # 生成假数据，faker重构版本
  gem 'guard-rails', require: false
  gem 'factory_girl_rails'  # 测试数据
end

group :test do
  gem 'rspec'               # rspec 测试框架
  gem 'rspec-rails'         # for respec
  gem 'database_cleaner'    # 测试数据库清理
  gem 'shoulda'
end

gem 'oneapm_rpm'
gem 'administrate'
