class Admin::ArticlesController < Admin::ApplicationController
  def attributes
    %w(user_name user_email content status)
  end
end
