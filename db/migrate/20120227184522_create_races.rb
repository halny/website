class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|
      t.datetime :registration_open_from
      t.datetime :registration_closed_at
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
