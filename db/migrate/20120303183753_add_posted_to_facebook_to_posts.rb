class AddPostedToFacebookToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :posted_to_facebook, :boolean
  end
end
