class ChangeLatAndLongToFloat < ActiveRecord::Migration
  def change
    remove_column :tweets, :latitude
    remove_column :tweets, :longitude
    add_column :tweets, :latitude, :float
    add_column :tweets, :longitude, :float
  end
end
