module GroupsHelper
  def logo group, size
    if group.logo_file_name
      image_tag group.logo.url(size), alt: group.name, class: 'logo'
    else
      image_tag "#{size}/default_logo.png", alt: group.name, class: 'logo'
    end
  end

  def is_in_groups? groups
    current_user and not (current_user.groups & groups).empty?
  end
end
