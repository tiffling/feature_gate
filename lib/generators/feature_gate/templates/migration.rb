class CreateGatedFeatures < ActiveRecord::Migration
  def change
    create_table :gated_features do |t|
      t.text :name, null: false
      t.boolean :gated, default: true, null: false
      t.timestamps
    end

    add_index :gated_features, :name, unique: true
  end
end
