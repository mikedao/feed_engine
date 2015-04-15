class AddPublishedTimeToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :published_time, :datetime
  end
end
