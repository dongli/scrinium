class ArticlePolicy < ApplicationPolicy
  def create?
    login? and user.role != 'guest'
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
