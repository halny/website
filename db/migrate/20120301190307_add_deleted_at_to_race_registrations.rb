class AddDeletedAtToRaceRegistrations < ActiveRecord::Migration
  def change
    add_column :race_registrations, :deleted_at, :time
  end
end
