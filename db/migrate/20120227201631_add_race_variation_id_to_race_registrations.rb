class AddRaceVariationIdToRaceRegistrations < ActiveRecord::Migration
  def change
    add_column :race_registrations, :race_variant_id, :integer
  end
end
