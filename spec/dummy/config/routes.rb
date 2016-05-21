Rails.application.routes.draw do
  mount FeatureGate::Engine => "/feature_gate"
end
