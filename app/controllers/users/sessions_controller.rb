class Users::SessionsController < Devise::SessionsController
  layout 'slim_page'

  protected

  def after_sign_out_path_for user
    "http://#{request.domain}#{":#{request.port}" if request.port}"
  end

  def after_sign_in_path_for resource
    if session[:previous_url].last != '/'
      session[:previous_url].last
    else
      user_path(resource)
    end
  end
end
