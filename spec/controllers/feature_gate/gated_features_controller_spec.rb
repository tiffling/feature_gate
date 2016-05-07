require 'spec_helper'

describe FeatureGate::GatedFeaturesController do
  routes { FeatureGate::Engine.routes }

  describe '#update' do
    it 'marks a gate as closed' do
      gate = create(:gated_feature, :open)
      put :update, id: gate.id, gated: 'true'
      expect(gate.reload).to be_gated
    end

    it 'marks a gate as opened' do
      gate = create(:gated_feature)
      put :update, id: gate.id, gated: 'false'
      expect(gate.reload).not_to be_gated
    end
  end
end
