class GroupPolicy < ApplicationPolicy
  def create?
    # 应该限制一下用户可以创建群组的数量。
    login? and user.role != 'guest'
  end

  def update?
    login? and ( user.role == 'admin' or user.id == record.admin_id )
  end

  def destroy?
    login? and user.role == 'admin'
  end

  def create_post?
    login? and user.groups.include? record
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
