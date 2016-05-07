module FeatureGate
  class Manager
    def self.gate_page(name)
      gated_feature = GatedFeature.where(name: name).first_or_create
      if gated_feature.gated?
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    def self.gate(name)
      gated_feature = GatedFeature.where(name: name).first_or_create
      if !gated_feature.gated?
        yield
      end
    end

    def self.opened_gates
      GatedFeature.opened.pluck(:name)
    end

    def self.closed_gates
      GatedFeature.closed.pluck(:name)
    end

    def self.stale_gates
      GatedFeature.stale.pluck(:name)
    end

    def self.open!(name)
      gated_feature = GatedFeature.find_by_name!(name)
      gated_feature.deploy_feature!
    end

    def self.close!(name)
      gated_feature = GatedFeature.find_by_name!(name)
      gated_feature.gate_feature!
    end

    def self.destroy!(name)
      gate = GatedFeature.find_by_name!(name)
      if gate.destroyable?
        gate.destroy!
        puts "#{gate.name} destroyed"
      else
        puts "#{gate.name} is currently being used in the codebase, execute `feature_gate_cleaner #{gate.name}` in the terminal to remove all references to #{gate.name}"
      end
    end
  end
end
