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

## Optional Configurations

Add `config/initializers/feature_gate.rb`

    FeatureGate.setup do |config|
      config.time_to_stale = 2.weeks # time until a gate is listed as stale, default is 1 month.
    end

## Usage

### Gating features

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

### Managing gates

#### Option 1: UI interface

<img src="http://i.imgur.com/aeRlKv0.png" border="1">

Go to `/feature_gate` for a preconfigured page that lists all your gates and give you the ability to toggle them open or close.

To limit accessibility to this page, define `feature_gate_control_allowed?` in `application_controller.rb`. If the method is not defined, `/feature_gate` will be accessible to <em>all</em> users.

    def feature_gate_control_allowed?
      # condition for allowing user to toggle feature gates, ex: current_admin_user.present?
    end

#### Option 2: Console

To deploy your feature:

    FeatureGate::Manager.open!('gate-name')

To gate your feature:

    FeatureGate::Manager.close!('gate-name')

To see the names of all opened gates:

    FeatureGate::Manager.opened_gates

To see the names of all closed gates:

    FeatureGate::Manager.closed_gates

To see the names of all stale gates:

    FeatureGate::Manager.stale_gates
