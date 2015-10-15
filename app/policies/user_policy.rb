class UserPolicy < ApplicationPolicy
  def update?
    login? and user.id == record.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
