Rails.application.routes.draw do
  resources :feature_gates, only: [:index, :update]
end
