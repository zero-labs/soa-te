class CreateAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :audio_files do |t|
      t.column :filename, :string
      t.column :sound_id, :integer
    end
  end

  def self.down
    drop_table :audio_files
  end
end
