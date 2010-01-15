require 'xspf'

class Sound < ActiveRecord::Base
  has_one :audio_file, :dependent => :destroy
  has_many :taggings, :dependent => :destroy
  has_many :tags, :through => :taggings
  
  validates_presence_of :title
  validates_presence_of :latitude
  validates_presence_of :longitude
  validates_presence_of :recorded_at
  validates_presence_of :audio_file, :on => :save
  
  validates_numericality_of :latitude, :on => :save
  validates_numericality_of :longitude, :on => :save
    
  # This has to be executed after creating/updating the Sound object so we have 
  # an Id for the Sound and can thus associate it with the given tags
  after_create :associate_tags
  after_update :associate_tags
  
  def tags=(tag_list)
    @tags = []
    tag_list.split(/,/).each do |tag|
      t = tag[/\w+(\s+\w+)*/] 
      @tags << t unless t.blank?
    end
  end
  
  def uploaded_file=(incoming_file)
    return if incoming_file.blank?
    self.audio_file = AudioFile.new
    self.audio_file.file = incoming_file
  end
  
  def self.day_playlist
    sounds = Array.new(24) {|i| []}
    result = Array.new(24)
    all = Sound.find :all
    
    all.each do |s|
      sounds[s.recorded_at.hour].push s
    end
    
    24.times do |hour|
      result[hour] = sounds[hour][rand(sounds[hour].size)]
    end
    
    create_playlist(result, "Day")
  end
  
  private
  
  def associate_tags
    return if @tags.nil?
    
    self.taggings.destroy_all
    @tags.each do |t|
      begin
        tag = Tag.find_or_create_by_name(t.downcase)
        tagging = Tagging.new(:tag => tag, :sound => self)
        tagging.save
      rescue
        # Do nothing (ignore errors) -> this is intentional
      end
    end
    @tags = nil
  end
  
  def self.create_playlist(sounds, title)
    tracklist = XSPF::Tracklist.new
    
    sounds.each do |s|
      unless s.nil? then
        tracklist << XSPF::Track.new({
          :location => s.audio_file.location,
          :title => s.recorded_at.hour.to_s + "H",
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
