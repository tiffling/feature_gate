class GatedFeature < ActiveRecord::Base
  validates :name, presence: true
  validates :gated, inclusion: { in: [true, false] }

  def turn_on!
    self.gated = false
    save!
  end

  def turn_off!
    self.gated = true
    save!
  end
end
