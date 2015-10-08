class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location

  protected

  def store_location
    session[:previous_url] = [] if not session[:previous_url] or session[:previous_url].class != Array
    # Store last url except for Devise urls.
    return unless request.get?
    if not request.path =~ /(^\/d\/users)|(edit$)/ and not request.xhr?
      session[:previous_url] << request.fullpath
      session[:previous_url].shift if session[:previous_url].size > 5
    end
  end

  def after_sign_in_path_for resource
    session[:previous_url] ? session[:previous_url].last : root_path
  end
end
