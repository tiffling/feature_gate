module FeatureGate
  class Engine < Rails::Engine
    isolate_namespace FeatureGate

    initializer 'feature_gate.assets.precompile' do |app|
      app.config.assets.precompile += %w(feature_gate/application.scss.css)
    end
  end
end
