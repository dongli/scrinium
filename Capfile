require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/bundler'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'
require 'capistrano/passenger'
require 'capistrano/sidekiq'
# require 'capistrano/sidekiq/monit'

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
