module FeatureGate
  class GatedFeaturesController < ApplicationController
    before_filter :ensure_feature_gate_control_allowed
    layout 'feature_gate/application'

    def index
      @closed_gates = FeatureGate::GatedFeature.closed
      @opened_gates = FeatureGate::GatedFeature.opened
      @stale_gates = FeatureGate::GatedFeature.stale.order(:updated_at)
    end

    def update
      gate = FeatureGate::GatedFeature.find(params[:id])
      if params[:gated] == 'true'
        gate.gate_feature!
        flash[:notice] = "#{gate.name} has been gated"
      else
        gate.deploy_feature!
        flash[:success] = "#{gate.name} is live!"
      end

      redirect_to gated_features_path
    end

    def destroy
      gate = FeatureGate::GatedFeature.find(params[:id])
      if gate.destroyable?
        gate.destroy!
        flash[:success] = "#{gate.name} has been deleted"
      else
        flash[:error] = "#{gate.name} is currently being used in the codebase, execute `feature_gate_cleaner #{gate.name}` in the terminal to remove all references to #{gate.name}"
      end

      redirect_to gated_features_path
    end

    private

    define_method(:feature_gate_control_allowed?) do
      true
    end unless method_defined? :feature_gate_control_allowed?

    def ensure_feature_gate_control_allowed
      return if feature_gate_control_allowed?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
