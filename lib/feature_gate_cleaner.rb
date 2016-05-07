module FeatureGateCleaner
  def self.clean(gate_name)
    matching_string = "(FeatureGate::Manager.gate(\s|\\()[\\\"\\']#{gate_name}[\\\"\\'])|(<%\s*end\s*#\s*#{gate_name}\s*%>)"

    `grep -r -l -E "#{matching_string}" #{Dir.pwd}/app/views/ | while IFS= read -r file; do grep -v -E "#{matching_string}" "$file" > "$file".cleaned; mv "$file"{.cleaned,}; done`

    matching_string = "FeatureGate::Manager.gate_page(\s|\\()[\\\"\\']#{gate_name}[\\\"\\']"

    `grep -r -l -E "#{matching_string}" #{Dir.pwd}/app/controllers/ | while IFS= read -r file; do grep -v -E "#{matching_string}" "$file" > "$file".cleaned; mv "$file"{.cleaned,}; done`

    puts "#{gate_name} cleaned!"
  end
end
