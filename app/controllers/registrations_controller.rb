class RegistrationsController < Devise::RegistrationsController
  protected

  def update_resource resource, params
    resource.update_without_password sign_up_params
  end

  private

  def sign_up_params
    UsersHelper.transform_user_params params
    params.require(:user).permit(:name,
                                 :gender,
                                 :organization_id,
                                 :research_team_id,
                                 :position,
                                 :email,
                                 :role,
                                 :password,
                                 :password_confirmation)
  end
end
