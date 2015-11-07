class Admin::UsersController < Admin::ApplicationController




  def attributes
    %w(
      id
      name
      email
      mobile
      role
      current_organization_id
      confirmed_at
      created_at
      updated_at
    )
  end

  def permitted_attributes
    %w(name email mobile role current_organization_id  confirmed_at)
  end

end

