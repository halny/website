class CreateRaceVariants < ActiveRecord::Migration
  def change
    create_table :race_variants do |t|
      t.string :name
      t.integer :capacity
      t.string :description

      t.timestamps
    end
  end
end
