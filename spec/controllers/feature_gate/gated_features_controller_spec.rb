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

  describe '#destroy' do
    let!(:gate){ create(:gated_feature) }

    before do
      allow(FeatureGate::GatedFeature).to receive(:find).and_return(gate)
    end

    it 'destroys the gate if it is destroyable' do
      allow(gate).to receive(:destroyable?).and_return true
      expect do
        delete :destroy, id: gate.id
      end.to change{ FeatureGate::GatedFeature.count }.by(-1)
    end

    it 'does not destory the gate if it is not destroyable' do
      allow(gate).to receive(:destroyable?).and_return false
      expect do
        delete :destroy, id: gate.id
      end.not_to change{ FeatureGate::GatedFeature.count }
    end
  end
end
