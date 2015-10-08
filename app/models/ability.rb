class Ability
  include CanCan::Ability

  def initialize user
    user ||= User.new
    send("#{user.role}_ability", user)
  end

  def admin_ability user
    can :manage, :all
  end

  def assist_admin_ability user
    can :manage, :all
  end

  def user_ability user
    can :read, :all
    can [ :update, :delete ], :all do |object|
      res = false
      [ :contact_id, :user_id, :admin_id ].each do |id|
        next if not object.respond_to? id
        if object.send(id) == user.id
          res = true
          break
        end
      end
      res
    end
  end

  def guest_ability user
    can :read, :all
  end
end
