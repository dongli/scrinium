class ResourcePolicy < ApplicationPolicy
  def create?
    login? and user.role != 'guest' and user.user_quotum.resources_size + record.file.file.size / 1000.0 / 1000.0 < user.user_quotum.max_resources_size
  end

  def update?
    login? and user.id == record.user_id
  end

  def destroy?
    login? and user.id == record.user_id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
