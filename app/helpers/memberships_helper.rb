module MembershipsHelper
  def is_user_in? host, host_class, user = nil
    user ||= current_user
    user.send(host_class.to_s.downcase.pluralize.to_sym).map { |x| x.id == host.id }.include? true if user
  end
end
