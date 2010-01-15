class AddContentType < ActiveRecord::Migration
  def self.up
    add_column :audio_files, :content_type, :string
  end

  def self.down
    remove_column :audio_files, :content_type
  end
end
