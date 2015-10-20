module GroupsHelper
  def logo group, options = {}
    size = options[:size] || :thumb
    klass = options[:class] || 'avatar'
    if group.logo
      if size.class == Symbol
        image_tag group.logo_url(size), alt: group.name, class: klass
      elsif size.class == String
        image_tag group.logo_url, alt: group.name, class: klass, size: size
      end
    else
      image_tag "#{size}/default_avatar.png", alt: group.name, class: klass
    end
  end

  def is_in_groups? groups
    current_user and not (current_user.groups & groups).empty?
  end
end
