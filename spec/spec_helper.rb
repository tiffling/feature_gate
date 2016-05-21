ENV['RAILS_ENV'] ||= 'test'

require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rspec/rails'
require 'factory_girl'
require 'factories'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Rails.application.routes.url_helpers
  config.infer_spec_type_from_file_location!
  config.default_formatter = 'doc'
  config.before(:each) do
    FeatureGate::GatedFeature.delete_all
  end
end
