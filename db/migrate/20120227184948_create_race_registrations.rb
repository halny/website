class CreateRaceRegistrations < ActiveRecord::Migration
  def change
    create_table :race_registrations do |t|
      t.boolean :is_student
      t.boolean :is_member
      t.string :email
      t.string :telephone
      t.string :name
      t.string :lastname
      t.integer :paid
      t.string :notes

      t.timestamps
    end
  end
end
