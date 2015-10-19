module OrganizationsHelper
  def logo organization, options = {}
    size = options[:size] || :thumb
    klass = options[:class] || 'avatar'
    if organization.logo
      image_tag organization.logo_url(size), alt: organization.name, class: klass
    else
      image_tag "#{size}/default_avatar.png", alt: organization.name, class: klass
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
