module UsersHelper
  def get_gravatar user, size = 70
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "http://www.gravatar.com/avatar.php?"
    gravatar_url << "gravatar_id=#{gravatar_id}"
    gravatar_url << "&size=160px"
    image_tag(gravatar_url, alt: user.full_name, class: "gravatar")
  end
end
