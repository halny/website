class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :content
      t.boolean :active
      t.boolean :show_in_navbar
      t.time :deleted_at

      t.timestamps
    end
  end
end
