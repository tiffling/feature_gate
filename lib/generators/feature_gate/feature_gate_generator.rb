require 'rails/generators/active_record'

class FeatureGateGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  source_root File.expand_path('../templates', __FILE__)

  desc 'creates gated_features table'

  def install
    migration_template 'migration.rb', 'db/migrate/create_gated_features.rb'
  end

  def self.next_migration_number(dirname)
    ActiveRecord::Generators::Base.next_migration_number(dirname)
  end
end
