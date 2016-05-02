class FeatureGate
  def self.gate
    if true
      yield
    end
  end
end
