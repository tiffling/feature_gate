# Classes required for the tests
# class User; end
# module ApplicationHelper; def current_user; raise; end; end

# Create a rails app
module FeatureGate
  class Application < Rails::Application
    config.secret_key_base = 'test'
    config.paths['config/database'] = ['spec/support/database.yml']
    config.eager_load = false
  end
end
FeatureGate::Application.initialize!

# Run migrations
require_relative '../lib/generators/feature_gate/templates/migration'
CreateGatedFeatures.suppress_messages { CreateGatedFeatures.new.change }
