require 'spec_helper'

describe FeatureGate::GatedFeature do
  let!(:gate) { create(:gated_feature) }

  describe '#destroyable?' do
    it 'returns true if files do not contain any feature gate references' do
      text = <<-TEXT
        <div>
          <% FeatureGate::Manager.gate('test') do %>
            foo
          <% end %>
        </div>

        def index
          FeatureGate::Manager.gate_page('test')
        end
      TEXT

      fake_file = double(read: text)
      allow(File).to receive(:new).and_return(fake_file)
      expect(gate).to be_destroyable
    end

    it 'returns false if files contain feature gate gating a page' do
      text = <<-TEXT
        <div>
          <% FeatureGate::Manager.gate('#{gate.name}') do %>
            foo
          <% end %>
        </div>

        def index
          FeatureGate::Manager.gate_page('test')
        end
      TEXT

      fake_file = double(read: text)
      allow(File).to receive(:new).and_return(fake_file)
      expect(gate).not_to be_destroyable
    end

    it 'return false if files contain feature gate gating part of a page' do
      text = <<-TEXT
        <div>
          <% FeatureGate::Manager.gate('test') do %>
            foo
          <% end %>
        </div>

        def index
          FeatureGate::Manager.gate_page('#{gate.name}')
        end
      TEXT

      fake_file = double(read: text)
      allow(File).to receive(:new).and_return(fake_file)
      expect(gate).not_to be_destroyable
    end
  end
end
