class HomeController < ApplicationController
  layout 'home_page'

  def index
    redirect_to current_user if user_signed_in?
  end

  def about
  end
end
