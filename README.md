# feature_gate

A gem to help toggle features on and off in Rails applications without having to re-deploy.

## Installation

Include gem in Gemfile:

    gem 'feature_gate'

Run generator to create the migration needed

    rails generate feature_gate

Migrate to create the table in your DB:

    rake db:migrate

Add to `config/routes.rb`

    mount FeatureGate::Engine, at: '/feature_gate'

## Usage

All gates are closed by default, meaning the features you gate will be hidden until you toggle the gates open.

In view files:

    <% FeatureGate::Manager.gate('gate-name') do %>
      <h1>This is my gated content</h1>
      <p>I am not seen if the gate is on</p>
    <% end %>

In controller actions:

    def index
      FeatureGate::Manager.gate_page('gate-name') # 404s if gate is closed
    end

To deploy your feature:

    FeatureGate::Manager.open!('gate-name')

To gate your feature:

    FeatureGate::Manager.close!('gate-name')

To see the names of all opened gates:

    FeatureGate::Manager.opened_gates

To see the names of all closed gates:

    FeatureGate::Manager.closed_gates
