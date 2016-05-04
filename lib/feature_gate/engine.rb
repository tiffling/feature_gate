module FeatureGate
  class Engine < Rails::Engine
    initialize 'feature_gate.load_app_instance_data' do |app|
      FeatureGate.setup do |config|
        config.app_root = app.root
      end
    end
  end
end
