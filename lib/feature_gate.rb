require 'active_support/dependencies'

module FeatureGate
  # Our host application root path
  # We set this when the engine is initialized
  mattr_accessor :app_root

  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end

  def self.gate(name)
    gated_feature = GatedFeature.where(name: name).first_or_create
    if !gated_feature.gated?
      yield
    end
  end
end

require 'feature_gate/engine'
