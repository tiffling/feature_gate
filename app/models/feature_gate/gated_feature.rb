module FeatureGate
  class GatedFeature < ActiveRecord::Base
    self.table_name = 'feature_gate_gated_features'

    validates :name, presence: true
    validates :gated, inclusion: { in: [true, false] }

    scope :opened, -> { where(gated: false) }
    scope :closed, -> { where(gated: true) }
    scope :stale, -> { where('updated_at != created_at and updated_at < ?', Time.zone.now - FeatureGate.time_to_stale) }

    def deploy_feature!
      self.gated = false
      save!
    end

    def gate_feature!
      self.gated = true
      save!
    end

    def status
      if gated
        'closed'
      else
        'opened'
      end
    end

    def destroyable?
      regex = /FeatureGate::Manager.gate(\(|\s)('|")#{name}('|")|FeatureGate::Manager.gate_page(\(|\s)('|")#{name}('|")/
      files = Dir["#{Dir.pwd}/app/views/**/*.html.erb"] + Dir["#{Dir.pwd}/app/controllers/**/*.rb"]

      files.each do |file|
        f = File.new(file)
        text = f.read
        return false if text =~ regex
      end

      true
    end
  end
end
