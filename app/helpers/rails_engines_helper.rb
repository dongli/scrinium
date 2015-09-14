module RailsEnginesHelper
  def self.engine_names
    @@engine_names ||= Rails::Engine.subclasses.map(&:instance).map { |x|
      name = x.class.to_s.split('::').first.underscore
      next if not name =~ /scrinium_/
      name
    }.select { |x| x }
  end
end
