class CreateTabs < ActiveRecord::Migration
  def change
    create_table :tabs do |t|
      t.time :deleted_at
      t.time :from
      t.time :to
      t.string :organizers
      t.string :name
      t.string :finish
      t.string :place

      t.timestamps
    end
  end
end
