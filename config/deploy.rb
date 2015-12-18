lock '3.4.0'

set :application, 'scrinium'

# 仓库设定
set :scm, :git
set :repo_url, 'git@github.com:tianlu1677/scrinium.git'
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# 部署设定
root_path = "/home/scrinium/projects/#{fetch(:application)}"
ruby_path = '/opt/software/packman.active'
set :deploy_user, 'scrinium'
set :deploy_to, root_path

set :format, :pretty
set :log_level, :debug
set :default_shell, '/bin/bash -l'
set :sidekiq_config, "#{root_path}/current/config/sidekiq.yml"
set :default_env, { path: "#{ruby_path}/bin:$PATH" }

# 链接到shared下的文件
set :linked_files, fetch(:linked_files, []).push(%w(
  config/database.yml
  config/secrets.yml
  config/sidekiq.yml
  config/nginx.conf
))

# 链接到shared下的目录
set :linked_dirs, fetch(:linked_dirs, []).push(%w(
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
))

# 保留发布的份数
set :keep_releases, 5

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      execute " kill -USR2 `cat /home/scrinium/projects/scrinium/current/tmp/pids/unicorn.pid` "
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  after :publishing, :restart
  after :finishing, "deploy:cleanup"
end
