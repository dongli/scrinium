module UsersHelper
  def avatar user, options = {}
    size = options[:size] || :thumb
    # 处理内部数据不一致问题，应该很少出现。
    if not user or not user.profile
      if size.class == Symbol
        return image_tag "#{size}/default_avatar.png"
      elsif size.class == String
        return image_tag "logos/default_avatar.png", size: size
      end
    end
    if user.profile.avatar.url
      klass = options[:class] || 'avatar'
      if size.class == Symbol
        image_tag user.profile.avatar_url(size), alt: user.name, class: klass
      elsif size.class == String
        image_tag user.profile.avatar_url, alt: user.name, class: klass, size: size
      end
    else
      if size.class == Symbol
        image_tag "#{size}/default_avatar.png", alt: user.name
      elsif size.class == String
        image_tag "logos/default_avatar.png", alt: user.name, size: size
      end
    end
  end
end
