class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_student, :boolean
    add_column :users, :is_member, :boolean
    add_column :users, :telephone, :string
    add_column :users, :name, :string
    add_column :users, :lastname, :string
  end
end
