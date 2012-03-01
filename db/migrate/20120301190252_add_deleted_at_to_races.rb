class AddDeletedAtToRaces < ActiveRecord::Migration
  def change
    add_column :races, :deleted_at, :time
  end
end
