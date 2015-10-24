module UsersHelper
  def avatar user, options = {}
    size = options[:size] || :thumb
    klass = options[:class] || 'avatar'
    if user.profile.avatar
      if size.class == Symbol
        image_tag user.profile.avatar_url(size), alt: user.name, class: klass
      elsif size.class == String
        image_tag user.profile.avatar_url, alt: user.name, class: klass, size: size
      end
    else
      image_tag "#{size}/default_avatar.png", alt: user.name, class: klass
    end
  end
end
