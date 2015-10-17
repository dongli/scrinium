app_root = File.expand_path(File.dirname(__FILE__) + '/..')

working_directory app_root

pid "#{app_root}/tmp/pids/unicorn.pid"

stderr_path "#{app_root}/log/unicorn.log"
stdout_path "#{app_root}/log/unicorn.log"

listen "#{app_root}/tmp/sockets/unicorn.sock", :backlog => 64

worker_processes 2
preload_app true
timeout 60
