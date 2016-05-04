module FeatureGate
  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end
end

require 'feature_gate/engine'
