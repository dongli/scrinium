class LicensePolicy < ApplicationPolicy
  def create?
    login? and user.role == 'admin'
  end

  def update?
    login? and user.role == 'admin'
  end

  def destroy?
    login? and user.role == 'admin'
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
