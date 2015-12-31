# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    before_filter :authenticate_admin

    def authenticate_admin
      if not user_signed_in?
        session[:previous_url] << request.fullpath
        session[:previous_url].shift if session[:previous_url].size > 5
        redirect_to new_user_session_path, alert: '如果您是管理员，请您登录。如果不是，那么您无权访问后台！'
      elsif current_user.role != 'admin'
        redirect_to current_user, alert: '您无权访问后台！'
      end
    end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
