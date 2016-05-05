class CreateFeatureGateGatedFeatures < ActiveRecord::Migration
  def change
    create_table :feature_gate_gated_features do |t|
      t.text :name, null: false
      t.boolean :gated, default: true, null: false
      t.timestamps
    end

    add_index :feature_gate_gated_features, :name, unique: true
  end
end
