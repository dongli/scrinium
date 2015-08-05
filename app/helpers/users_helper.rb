module UsersHelper
  def get_gravatar user, size = 70
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://www.gravatar.com/avatar.php?"
    gravatar_url << "gravatar_id=#{gravatar_id}"
    gravatar_url << "&size=#{size}px"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def is_super_admin? user
    user and user.role == t('user.role_types.super_admin')
  end

  def is_admin? user
    user and user.role == t('user.role_types.admin')
  end

  def is_super_admin_or_admin? user
    is_super_admin?(user) or is_admin?(user)
  end

  def is_user? user
    user and user.role == t('user.role_types.user')
  end

  def is_guest user
    user and user.role == t('user.role_types.guest')
  end

  def is_same_user? user
    current_user and current_user == user
  end
end
