app_root = File.expand_path(File.dirname(__FILE__) + '/..')

working_directory app_root

rails_env = ENV['RAILS_ENV'] || 'production'

cpu_cores = if File.exist? '/proc/cpuinfo'    # Linux
              File.read('/proc/cpuinfo').scan(/^processor\s*:/).size
            else                              # Darwin ( for the other: default 8)
              Integer `sysctl -n hw.ncpu 2>/dev/null` rescue 8
            end

worker_processes (rails_env == 'production' ? cpu_cores : 4)

listen "#{app_root}/shared/tmp/sockets/unicorn.sock", :backlog => 1024

timeout 30

# pid "#{app_root}/shared/tmp/pids/unicorn.pid"

stdout_path "#{app_root}/log/unicorn_stdout.log"
stderr_path "#{app_root}/log/unicorn_stderr.log"

preload_app true

GC.respond_to?(:copy_on_write_friendly=) and
    GC.copy_on_write_friendly = true

check_client_connection false

# before_exec do |server|
#   ENV['BUNDLE_GEMFILE'] = "#{root}/Gemfile"
# end

before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end

  # Throttle the master from forking too quickly by sleeping.  Due
  # to the implementation of standard Unix signal handlers, this
  # helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy.

end

after_fork do |server, worker|

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end

# run this before start master process
# Ref: BUNDLE_GEMFILE for capistrano <http://unicorn.bogomips.org/Sandbox.html>
#      Book <deploying_rails_application-cn1.pdf> Page 113
before_exec do |server|
  ENV["BUNDLE_GEMFILE"] = "#{app_root}/current/Gemfile"
  # ENV['BUNDLE_GEMFILE'] = "<%= current_path %>/Gemfile"
end

# # unicorn_rails -c /data/github/current/config/unicorn.rb -E production -D
#
# rails_env = ENV['RAILS_ENV'] || 'production'
#
# # 16 workers and 1 master
# worker_processes (rails_env == 'production' ? 16 : 4)
#
# # Load rails+github.git into the master before forking workers
# # for super-fast worker spawn times
# preload_app true
#
# # Restart any workers that haven't responded in 30 seconds
# timeout 30
#
# # Listen on a Unix data socket
# listen '/data/github/current/tmp/sockets/unicorn.sock', :backlog => 2048
#
#
# ##
# # REE
#
# # http://www.rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
# if GC.respond_to?(:copy_on_write_friendly=)
#   GC.copy_on_write_friendly = true
# end
#
#
# before_fork do |server, worker|
#   ##
#   # When sent a USR2, Unicorn will suffix its pidfile with .oldbin and
#   # immediately start loading up a new version of itself (loaded with a new
#   # version of our app). When this new Unicorn is completely loaded
#   # it will begin spawning workers. The first worker spawned will check to
#   # see if an .oldbin pidfile exists. If so, this means we've just booted up
#   # a new Unicorn and need to tell the old one that it can now die. To do so
#   # we send it a QUIT.
#   #
#   # Using this method we get 0 downtime deploys.
#
#   old_pid = RAILS_ROOT + '/tmp/pids/unicorn.pid.oldbin'
#   if File.exists?(old_pid) && server.pid != old_pid
#     begin
#       Process.kill("QUIT", File.read(old_pid).to_i)
#     rescue Errno::ENOENT, Errno::ESRCH
#       # someone else did our job for us
#     end
#   end
# end
#
#
# after_fork do |server, worker|
#   ##
#   # Unicorn master loads the app then forks off workers - because of the way
#   # Unix forking works, we need to make sure we aren't using any of the parent's
#   # sockets, e.g. db connection
#
#   ActiveRecord::Base.establish_connection
#   CHIMNEY.client.connect_to_server
#   # Redis and Memcached would go here but their connections are established
#   # on demand, so the master never opens a socket
#
#
#   ##
#   # Unicorn master is started as root, which is fine, but let's
#   # drop the workers to git:git
#
#   begin
#     uid, gid = Process.euid, Process.egid
#     user, group = 'git', 'git'
#     target_uid = Etc.getpwnam(user).uid
#     target_gid = Etc.getgrnam(group).gid
#     worker.tmp.chown(target_uid, target_gid)
#     if uid != target_uid || gid != target_gid
#       Process.initgroups(user, target_gid)
#       Process::GID.change_privilege(target_gid)
#       Process::UID.change_privilege(target_uid)
#     end
#   rescue => e
#     if RAILS_ENV == 'development'
#       STDERR.puts "couldn't change user, oh well"
#     else
#       raise e
#     end
#   end
# end
