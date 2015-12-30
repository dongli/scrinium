set :application, 'scrinium'

# 仓库设定
set :github_user, ask('GitHub user', 'dongli')
set :repo_url, "git@github.com:#{fetch(:github_user)}/scrinium.git"
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# 部署设定
set :deploy_to, ask('Deploy to remote path', "/home/scrinium/projects/#{fetch(:application)}")
set :tmp_dir, ask('Temporary directory', '/tmp')
set :default_env, { path: "/opt/software/packman.active/bin:$PATH" }

set :pty, true
set :format, :pretty
set :log_level, :debug
set :default_shell, '/bin/bash -l'
set :sidekiq_config, "#{fetch(:deploy_to)}/config/sidekiq.yml"

# 链接shared下的文件
set :linked_files, %w(
  config/database.yml
  config/secrets.yml
  config/sidekiq.yml
  config/nginx.conf
)

# 链接shared下的目录
set :linked_dirs, %w(
  log
  tmp/pids
  tmp/cache
  tmp/sockets
  vendor/bundle
  public/system
)

# 保留发布的份数
set :keep_releases, 5
