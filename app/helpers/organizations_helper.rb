module OrganizationsHelper
  def logo organization, size
    if organization.logo_file_name
      image_tag organization.logo.url(size), alt: organization.name, class: 'avatar'
    else
      image_tag "#{size}/default_avatar.png", alt: organization.name, class: 'avatar'
    end
  end
end
