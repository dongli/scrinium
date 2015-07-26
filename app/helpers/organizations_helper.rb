module OrganizationsHelper
  def set_current_organization id
    $organization_id = id
    $current_organization = Organization.find(id)
  end

  def self.current_organization
    $current_organization
  end
end
