class RemoveSoundComment < ActiveRecord::Migration
  def self.up
    remove_column :sounds, :comment
  end

  def self.down
    add_column :sounds, :comment, :text
  end
end
