# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_scrinium_session', domain: :all

# for redis session store
# Rails.application.config.session_store :redis_store, servers: { :host => Settings.redis_server_host,
#                                                                  :port => Settings.redis_server_port,
#                                                                  :db => 0,
#                                                                  :namespace => "session"
#                                                             }, domain: :all,
#
#                                                       :expires_in => 90.minutes