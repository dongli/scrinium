
Sidekiq.configure_server do |config|
    config.redis = { :url => "redis://#{Settings.redis_server_host}:#{Settings.redis_server_port}/12", namespace: 'sidekiq' }
end

Sidekiq.configure_client do |config|
    config.redis = { :url => "redis://#{Settings.redis_server_host}:#{Settings.redis_server_port}/12", :namespace => 'sidekiq' }
end

