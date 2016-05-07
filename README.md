# feature_gate

A gem to help manage toggling features on and off in Rails applications without having to re-deploy. Includes a preconfigured page for gate management and an executable for feature gate code cleanup in your codebase after a feature has been deployed.

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

To gate a part of a page (add `# gate-name` after `end` to allow the cleaner executable to remove this line when cleaning the gate out of the files):

    <% FeatureGate::Manager.gate('gate-name') do %>
      <h1>This is my gated content</h1>
      <p>I am not seen if the gate is on</p>
    <% end # gate-name %>

To gate an entire page:

    def index
      FeatureGate::Manager.gate_page('gate-name') # 404s if gate is closed
    end

### Managing gates

<img src="http://i.imgur.com/qo8zESV.png">

Go to `/feature_gate` for a preconfigured page to manage your gates. It lists all your gates and gives you the ability to toggle them open or closed. Additionally, it lists all your "stale" gates - gates that have not been touched in 1 month (timeframe is configurable, see under Optional Configurations) and allows you to delete them from your database *if* it is no longer used in your codebase (this check is done automatically when you try to delete a gate).


To limit accessibility to this page, define `feature_gate_control_allowed?` in `application_controller.rb`. If the method is not defined, `/feature_gate` will be accessible to <em>all</em> users.

    def feature_gate_control_allowed?
      # condition for allowing user to toggle feature gates, ex: current_admin_user.present?
    end

To remove gates from your codebase after the feature has officially launched use the cleaner executable

    $ feature_gate_cleaner gate_name

#### Console commands

If you prefer to use the console, you can also manage your gates with the following method calls:

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

To safely delete a gate (only deletes if not used in codebase):

    FeatureGate::Manager.destroy!('gate-name')
