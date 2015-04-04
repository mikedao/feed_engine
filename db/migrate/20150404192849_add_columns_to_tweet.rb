class AddColumnsToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :user_profile_image, :string
    add_column :tweets, :latitude, :string
    add_column :tweets, :longitude, :string
  end
end
