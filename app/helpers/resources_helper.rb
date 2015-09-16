module ResourcesHelper
  def filter_user options
    ResourcesHelper.filter_user options
  end

  def self.filter_user options
    options.delete_at(2) if options[2].class == User
    options
  end
end
