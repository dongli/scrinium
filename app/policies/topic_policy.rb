class TopicPolicy < ApplicationPolicy
  def create?
    login? and user.groups.include? record
  end

  def update?
    login? and user.id == record.user_id
  end

  def destroy?
    login? and ( user.id == record.user_id or user.admin? )
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
