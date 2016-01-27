class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    flash[:alert] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || root_path)
  end
end
