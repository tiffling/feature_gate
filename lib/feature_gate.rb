module FeatureGate
  mattr_accessor :time_to_stale
  self.time_to_stale = 1.month

  def self.setup
    yield self
  end
end

require 'feature_gate/engine'
