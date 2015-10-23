class PublisherPolicy < ApplicationPolicy
  def create?
    login?
  end

  def update?
    login?
  end

  def destroy?
    login? and user.role == 'admin'
  end

  def qualify?
    login? and user.role == 'admin'
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
