module RailsEnginesHelper
  def self.engine_names
    @@engine_names ||= []
  end

  def self.register engine_name
    engine_names << engine_name
  end
end
