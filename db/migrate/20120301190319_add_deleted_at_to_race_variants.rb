class AddDeletedAtToRaceVariants < ActiveRecord::Migration
  def change
    add_column :race_variants, :deleted_at, :time
  end
end
