module FeatureGate
  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :time_to_stale

    def initialize
      @time_to_stale = 1.month
    end
  end
end

require 'feature_gate/engine'
