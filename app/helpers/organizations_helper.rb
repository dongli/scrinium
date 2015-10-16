module OrganizationsHelper
  def logo organization, size
    if organization.logo_file_name
      image_tag organization.logo.url(size), alt: organization.name, class: 'avatar'
    else
      image_tag "#{size}/default_avatar.png", alt: organization.name, class: 'avatar'
    end
  end

  def active_engines organization
    res = []
    app_name = Rails.app_class.to_s.split('::').first.downcase
    organization.licenses.each do |license|
      res << app_name+'_'+license.engine_name
    end
    res
  end
end
