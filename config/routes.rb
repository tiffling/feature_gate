FeatureGate::Engine.routes.draw do
  resources :gated_features, only: [:index, :update]
  get '/' => 'gated_features#index'
end
