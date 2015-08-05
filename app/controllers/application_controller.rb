class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location

  protected

  def store_location
    # Store last url except for Devise urls.
    return unless request.get?
    if not request.path =~ /^\/d\/users/ and not request.xhr?
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for resource
    session[:previous_url] || root_path
  end
end
