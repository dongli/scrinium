module GroupsHelper
  def is_in_groups? groups
    current_user and not (current_user.groups & groups).empty?
  end
end
