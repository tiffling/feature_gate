module FeatureGate
  class GatedFeature < ActiveRecord::Base
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
  end
end
