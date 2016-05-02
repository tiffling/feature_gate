class GatedFeature < ActiveRecord::Base
  validates :name, presence: true
  validates :gated, inclusion: { in: [true, false] }
end
