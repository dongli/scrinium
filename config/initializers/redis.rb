$redis = Redis.new(:url => Rails.application.config.cache_store[1])
