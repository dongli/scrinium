module GroupsHelper
  def logo group, options = {}
    size = options[:size] || :thumb
    klass = options[:class] || 'avatar'
    if group.logo_file_name
      image_tag group.logo.url(size), alt: group.name, class: klass
    else
      image_tag "#{size}/default_avatar.png", alt: group.name, class: klass
    end
  end

  def is_in_groups? groups
    current_user and not (current_user.groups & groups).empty?
  end
end
