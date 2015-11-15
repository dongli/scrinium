if ENV['USE_OFFICIAL_GEM_SOURCE']
  source 'https://rubygems.org'
else
  source 'https://ruby.taobao.org'
end

gem 'rails', '4.2.4'

## 服务器部署
gem 'unicorn'
gem 'thin'

## 数据库
gem 'pg'
gem 'redis-rails'

## 视图和JavaScript
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'

## 用户验证与权限设置
gem 'devise'
gem 'pundit'

## 异步
gem "devise-async"
gem 'sidekiq'
gem 'sinatra', '>= 1.4.6', :require => nil

## UI
gem 'bootstrap-sass'
gem 'jasny-bootstrap-rails'
gem 'country_select'
gem 'font-awesome-rails'
gem 'bootstrap-datepicker-rails'
gem 'dropzonejs-rails'
gem 'i18n-js', '>= 3.0.0.rc11'
gem 'bower-rails'
gem 'momentjs-rails'
gem 'nprogress-rails'
gem 'jstree-rails-4'
# ActiveRecord model/data translation.
gem 'globalize', '~> 5.0.0'

## API
gem 'grape'
gem 'jbuilder', '~> 2.0'
gem 'grape-kaminari'
gem 'active_model_serializers'
gem 'grape-active_model_serializers'
gem 'rack-cors', require: 'rack/cors'
gem 'grape-swagger'
gem 'grape-swagger-rails'

## 文件上传
gem 'paperclip', '~> 4.3' # 等待删除
gem 'carrierwave'
gem 'mini_magick'
gem 'carrierwave-qiniu', '0.1.8'
gem 'file_validators'
gem 'remotipart'

## 编辑器
gem 'mathjax-rails', '~> 2.5.1'
gem "wysiwyg-rails", "2.0.0.pre.rc.3"

source 'https://rails-assets.org' do
  gem 'rails-assets-marked'
  gem 'rails-assets-highlightjs'
  gem 'rails-assets-jcrop'
end

## 全局设定
gem 'settingslogic'

## 其它
gem 'simple_form'
gem 'paper_trail', '~> 4.0.0'
gem 'closure_tree'
gem 'responders'

gem 'acts-as-taggable-on', '~> 3.4'
gem 'mailboxer'
gem 'message_bus'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'lograge'
gem 'enumerize'
gem 'inherited_resources'
gem 'acts_as_tenant'

## 搜索
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
gem 'ransack'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console.
  gem 'quiet_assets' # don't show assets log
  gem 'byebug'
  gem 'bullet'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring.
  gem 'spring'
  gem 'annotate'
  # Refresh browser auto.
  gem 'rack-livereload'
  gem 'guard-livereload'

  # Use Capistrano for deployment.
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem "capistrano-scm-copy"
  gem 'net-ssh', '~> 2.8.0'
  gem 'capistrano-sidekiq'

  # 插件
  # gem 'scrinium_esm', '0.0.1', path: '../scrinium_esm'
end
