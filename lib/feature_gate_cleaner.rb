module FeatureGateCleaner
  def self.clean(gate_name)
    matching_string = "FeatureGate::Manager.gate(\s*'#{gate_name}'\s*)|<%\s*end\s*#\s*#{gate_name}\s*%>"
    `egrep -r -l "#{matching_string}" #{Dir.pwd}/app/views/ | while IFS= read -r file; do grep -v "#{matching_string}" "$file" > "$file".cleaned; mv "$file"{.cleaned,}; done`

    matching_string = "FeatureGate::Manager.gate_page(\s*'#{gate_name}'\s*)"
    `grep -r -l "#{matching_string}" #{Dir.pwd}/app/controllers/ | while IFS= read -r file; do grep -v "#{matching_string}" "$file" > "$file".cleaned; mv "$file"{.cleaned,}; done`
    puts 'Cleaned!'
  end
end
