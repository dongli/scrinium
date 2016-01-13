module GroupsHelper
  def is_in_groups? groups
    current_user and not (current_user.groups & groups).empty?
  end

  def is_in_group? group
    current_user and current_user.groups.include? group
  end

  def get_valid_groups_of user
    user.memberships.where(host_type: 'Group', status: 'approved').map { |x| x.host }
  end
end
