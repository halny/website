class AddRaceIdToRaceVariants < ActiveRecord::Migration
  def change
    add_column :race_variants, :race_id, :integer
  end
end
