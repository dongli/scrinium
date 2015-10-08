module UsersHelper
  def avatar user, size
    if user.avatar_file_name
      image_tag user.avatar.url(size), alt: user.name, class: 'avatar'
    else
      image_tag "#{size}/default_avatar.png", alt: user.name, class: 'avatar'
    end
  end
end
