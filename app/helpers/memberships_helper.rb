module MembershipsHelper
  def is_user_in? host, user = nil
    user ||= current_user
    user.send(host.class.to_s.downcase.pluralize.to_sym).map { |x| x.id == host.id }.include? true if user
  end
end
