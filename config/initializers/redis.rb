$redis = Redis.new(:url => "redis://#{Settings['redis_server_host']}:#{Settings['redis_server_port']}/0/scrinium")
