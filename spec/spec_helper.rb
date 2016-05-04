ENV['RAILS_ENV'] = 'test'

require 'rails/all'
require 'rspec/rails'
require 'fake_app'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'factory_girl'
require 'factories'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Rails.application.routes.url_helpers
  config.infer_spec_type_from_file_location!
  config.default_formatter = 'doc'
  config.before(:each) do
    FeatureGate::GatedFeature.delete_all
  end
end
