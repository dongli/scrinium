# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# 订阅收藏更新消息。由于重启服务器后，之前在CollectionsController中的订阅失效，所以要
# 重新订阅。
# NOTE: 需要和collections_controller.rb中的回调函数保持一致！
if ActiveRecord::Base.connection.table_exists? 'users'
  User.all.each do |u|
    u.collections.each do |c|
      MessageBus.subscribe "/update-#{c.collectable_type}-#{c.collectable_id}" do |msg|
        c.updated = true
        if not c.save
          # TODO: 处理错误。
        end
      end
    end
  end
end
