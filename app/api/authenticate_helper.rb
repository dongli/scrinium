module AuthenticateHelper

  def session
    env[Rack::Session::Abstract::ENV_SESSION_KEY]
  end

  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

  def warden
    env['warden']
  end

  def authenticated
    return true if warden.authenticated?
    params[:access_token] && @user = User.find_by_authentication_token(params[:access_token])
  end

  def current_user
    warden.user || @user
  end
end