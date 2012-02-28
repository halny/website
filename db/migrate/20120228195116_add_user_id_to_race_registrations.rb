class AddUserIdToRaceRegistrations < ActiveRecord::Migration
  def change
    add_column :race_registrations, :user_id, :integer
  end
end
