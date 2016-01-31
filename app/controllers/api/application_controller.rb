class Api::ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def authenticate_user_from_token!
    access_token = request.headers['Authorization']
    if access_token
      authenticate_with access_token
    else
      authentication_error
    end
  end

  def unauthorized_to action, object
    render json: { error: "Unauthorized to #{action} #{object.class} ##{object.id}!" }, status: 403
  end

  private

  def authenticate_with access_token
    if not access_token.include? ':'
      authentication_error
      return
    end
    user_id = access_token.split(':').first
    user = User.find(user_id)
    if user and Devise.secure_compare user.access_token, access_token
      sign_in user, store: false
    else
      authentication_error
    end
  end

  def authentication_error
    render json: { error: 'Unauthorized access!' }, status: 401
  end
end
