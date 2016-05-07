FeatureGate::Engine.routes.draw do
  resources :gated_features, only: [:index, :update, :destroy]
  get '/' => 'gated_features#index'
end
