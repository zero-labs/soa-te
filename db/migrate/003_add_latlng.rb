class AddLatlng < ActiveRecord::Migration
  def self.up
    add_column :sounds, :latitude, :decimal, :precision => 15, :scale => 10
    add_column :sounds, :longitude, :decimal, :precision => 15, :scale => 10
  end

  def self.down
    remove_column :sounds, :latitude
    remove_column :sounds, :longitude
  end
end
