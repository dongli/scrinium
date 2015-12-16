module GroupsHelper
  def is_in_groups? groups
    current_user and not (current_user.groups & groups).empty?
  end

  def get_valid_groups_of user
    user.memberships.where(host_type: 'Group', status: 'approved').map { |x| x.host }
  end
end
