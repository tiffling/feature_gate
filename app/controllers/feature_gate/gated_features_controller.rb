module FeatureGate
  class GatedFeaturesController < ApplicationController
    def index
      @gates = FeatureGate::GatedFeature.all
    end

    def update
    end
  end
end
