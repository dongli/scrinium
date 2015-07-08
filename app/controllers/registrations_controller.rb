class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:full_name,
                                 :gender,
                                 :affiliation,
                                 :position,
                                 :email,
                                 :role,
                                 :password,
                                 :password_confirmation)
  end
end