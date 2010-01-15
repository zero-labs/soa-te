class CreateSounds < ActiveRecord::Migration
  def self.up
    create_table :sounds do |t|
      t.column :title, :string
      t.column :comment, :text
    end
  end

  def self.down
    drop_table :sounds
  end
end
