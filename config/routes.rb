FeatureGate::Engine.routes.draw do
  resources :gated_features, only: [:index, :update]

  root to: 'gated_features#index'
end
