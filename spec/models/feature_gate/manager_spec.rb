require 'spec_helper'

describe FeatureGate::Manager do
  describe '.gate' do
    it 'if the gate for the given name does not exist, create the gate and return nil' do
      expect do
        result = FeatureGate::Manager.gate('new_gate') do
          'foobar'
        end
        expect(result).to eq nil
      end.to change{ FeatureGate::GatedFeature.count }.by(1)
    end

    it 'if the gate does exist and it is closed, return nil' do
      create(:gated_feature, name: 'new_gate')

      expect do
        result = FeatureGate::Manager.gate('new_gate') do
          'foobar'
        end
        expect(result).to eq nil
      end.not_to change{ FeatureGate::GatedFeature.count }
    end

    it 'if the gate does exist and it is opened, yield' do
      create(:gated_feature, :open, name: 'new_gate')

      expect do
        result = FeatureGate::Manager.gate('new_gate') do
          'foobar'
        end
        expect(result).to eq 'foobar'
      end.not_to change{ FeatureGate::GatedFeature.count }
    end
  end

  describe '.gate_page' do
    it 'if the gate for the given name does not exist, create the gate and raise not found' do
      expect do
        FeatureGate::Manager.gate_page('new_gate')
      end.to raise_error(ActionController::RoutingError)
    end

    it 'if the gate does exist and it is closed, raise not found' do
      create(:gated_feature, name: 'new_gate')

      expect do
        FeatureGate::Manager.gate_page('new_gate')
      end.to raise_error(ActionController::RoutingError)
    end

    it 'if the gate does exist and it is opened do not raise' do
      create(:gated_feature, :open, name: 'new_gate')

      expect do
        FeatureGate::Manager.gate_page('new_gate')
      end.not_to raise_error
    end
  end

  describe '.opened_gates' do
    it 'returns names of all opened gates' do
      opened_gates = create_list(:gated_feature, 2, :open)
      create_list(:gated_feature, 2)

      expect(FeatureGate::Manager.opened_gates).to match_array(opened_gates.map(&:name))
    end
  end

  describe '.closed_gates' do
    it 'returns names of all closed gates' do
      create_list(:gated_feature, 2, :open)
      closed_gates = create_list(:gated_feature, 2)

      expect(FeatureGate::Manager.closed_gates).to match_array(closed_gates.map(&:name))
    end
  end

  describe '.open!' do
    it 'marks a given gate as open' do
      gate = create(:gated_feature)
      FeatureGate::Manager.open!(gate.name)
      expect(gate.reload).not_to be_gated
    end
  end

  describe '.close!' do
    it 'marks a given gate as closed' do
      gate = create(:gated_feature, :open)
      FeatureGate::Manager.close!(gate.name)
      expect(gate.reload).to be_gated
    end
  end
end
