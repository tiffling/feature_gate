class GatedFeature < ActiveRecord::Base
  validates :name, presence: true
  validates :gated, inclusion: { in: [true, false] }

  def deploy_feature!
    self.gated = false
    save!
  end

  def gate_feature!
    self.gated = true
    save!
  end
end
