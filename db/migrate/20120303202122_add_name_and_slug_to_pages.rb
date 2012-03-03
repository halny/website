class AddNameAndSlugToPages < ActiveRecord::Migration
  def change
    add_column :pages, :name, :string
    add_column :pages, :slug, :string
  end
end
