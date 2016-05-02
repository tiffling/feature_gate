class FeatureGate
  def self.gate(name)
    gated_feature = GatedFeature.where(name: name).first_or_create
    if !gated_feature.gated?
      yield
    end
  end
end
