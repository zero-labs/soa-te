class AddRecordingDate < ActiveRecord::Migration
  def self.up
    add_column :sounds, :recorded_at, :datetime
  end

  def self.down
    remove_column :sounds, :recorded_at
  end
end
