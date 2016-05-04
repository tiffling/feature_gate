require 'active_support/dependencies'

module FeatureGate
  # Our host application root path
  # We set this when the engine is initialized
  mattr_accessor :app_root

  # Yield self on setup for nice config blocks
  def self.setup
    yield self
  end

  def self.gate_page(name)
    gated_feature = GatedFeature.where(name: name).first_or_create
    if gated_feature.gated?
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def self.gate(name)
    gated_feature = GatedFeature.where(name: name).first_or_create
    if !gated_feature.gated?
      yield
    end
  end

  def self.open!(name)
    gated_feature = GatedFeature.find_by_name!(name)
    gated_feature.deploy_feature!
  end

  def self.close!(name)
    gated_feature = GatedFeature.find_by_name!(name)
    gated_feature.gate_feature!
  end
end

require 'feature_gate/engine'
