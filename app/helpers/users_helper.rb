module UsersHelper
  def avatar user, options = {}
    size = options[:size] || :thumb
    klass = options[:class] || 'avatar'
    if user.avatar_file_name
      image_tag user.avatar.url(size), alt: user.name, class: klass
    else
      image_tag "#{size}/default_avatar.png", alt: user.name, class: klass
    end
  end
end
