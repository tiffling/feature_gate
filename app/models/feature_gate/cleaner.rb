module FeatureGate
  class Cleaner
    def self.clean(gate_name)
      `grep -r #{gate_name} #{Dir.pwd}/app/views/`
    end
  end
end
