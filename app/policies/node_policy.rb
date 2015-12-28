class NodePolicy < ApplicationPolicy
  def manage?
    login? and ( record.group.admin_id == user.id )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
