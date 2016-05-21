module FeatureGate
  class << self
    attr_reader :configuration

    def configuration
      @configuration ||= Configuration.new
    end
  end

  def self.setup
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
