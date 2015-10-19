class MembershipPolicy < ApplicationPolicy
  def create?
    login?
  end

  def update?
    login? and ( user.id == record.host.admin_id or ( record.join_type.invited? and user.id == record.user_id ) )
  end

  def destroy?
    login? and user.id == record.host.admin_id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
