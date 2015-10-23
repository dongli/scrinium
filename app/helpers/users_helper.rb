module UsersHelper
  def avatar user, options = {}
    size = options[:size] || :thumb
    klass = options[:class] || 'avatar'
    if user.profile.avatar
      image_tag user.profile.avatar_url(size), alt: user.name, class: klass
    else
      image_tag "#{size}/default_avatar.png", alt: user.name, class: klass
    end
  end
end
