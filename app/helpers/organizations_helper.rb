module OrganizationsHelper
  def active_engines organization
    res = []
    app_name = Rails.app_class.to_s.split('::').first.downcase
    organization.licenses.each do |license|
      res << app_name+'_'+license.engine_name
    end
    res
  end
end
