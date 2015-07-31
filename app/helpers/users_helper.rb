module UsersHelper
  def get_gravatar user, size = 70
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://www.gravatar.com/avatar.php?"
    gravatar_url << "gravatar_id=#{gravatar_id}"
    gravatar_url << "&size=#{size}px"
    image_tag(gravatar_url, alt: user.full_name, class: "gravatar")
  end

  def get_role_string role
    case role
    when 0
      t('user.roles.super_admin')
    when 1
      t('user.roles.admin')
    when 2
      t('user.roles.user')
    when 3
      t('user.roles.guest')
    else
      t('user.roles.unknown')
    end
  end
end
