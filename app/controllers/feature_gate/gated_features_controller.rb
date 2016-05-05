module FeatureGate
  class GatedFeaturesController < ApplicationController
    layout 'feature_gate/application'

    def index
      @closed_gates = FeatureGate::GatedFeature.closed
      @opened_gates = FeatureGate::GatedFeature.opened
    end

    def update
      gate = FeatureGate::GatedFeature.find(params[:id])
      if params[:gated] == 'true'
        gate.gate_feature!
        flash[:notice] = 'Feature has been gated'
      else
        gate.deploy_feature!
        flash[:success] = 'Feature is live!'
      end

      redirect_to gated_features_path
    end
  end
end
