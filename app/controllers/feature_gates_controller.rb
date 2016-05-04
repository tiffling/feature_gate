class FeatureGatesController < ::ApplicationController
  def index
    @gates = FeatureGate::GatedFeature.all
  end

  def update
  end
end
