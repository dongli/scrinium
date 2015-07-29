class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource resource, params
    resource.update_without_password sign_up_params
  end

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