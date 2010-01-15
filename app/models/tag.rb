require 'xspf'

class Tag < ActiveRecord::Base
  has_many :taggings, :dependent => :destroy
  has_many :sounds, :through => :taggings

  validates_presence_of :name
  validates_uniqueness_of :name

  def playlist
    create_playlist(self.sounds, self.name)
  end
  
  def self.find_similar_by_name(name)
    find_options = { 
      :conditions => [ "LOWER(name) LIKE ?", '%' + name + '%' ], 
      :order => "name ASC",
      :limit => 10 }
    Tag.find(:all, find_options)
  end
  
  def self.tags(options = {})
    query = "select tags.id as id, tags.name as name, count(*) as count"
    query << " from taggings, tags"
    query << " where tags.id = taggings.tag_id"
    query << " group by tags.id, tags.name"
    query << " order by #{options[:order]}" if options[:order] != nil
    query << " limit #{options[:limit]}" if options[:limit] != nil
    tags = Tag.find_by_sql(query)
  end
  
  private 
  
  def create_playlist(sounds, title)
    tracklist = XSPF::Tracklist.new

    sounds.each do |s|
      unless s.nil? then
        tracklist << XSPF::Track.new({
          :location => s.audio_file.location,
          :title => s.title,
          :image => 'http://www.radiozero.pt/images/LogoRadioZero.jpg' })
      end
    end

    playlist = XSPF::Playlist.new({
      :xmlns => 'http://xspf.org/ns/0/',
      :title => title,
      :creator => 'Radio Zero',
      :license => 'http://creativecommons.org/licenses/by/2.5/pt/',
      :info => 'http://www.radiozero.pt/',
      :tracklist => tracklist })
    xspf = XSPF.new({:playlist => playlist})  
    xspf.to_xml
  end
end
