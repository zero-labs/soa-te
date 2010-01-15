class AudioFile < ActiveRecord::Base
  include UUIDNamer
  
  belongs_to :sound
  
  validates_presence_of :filename
  validates_presence_of :sound
  
  before_destroy :delete_file

  #validates_format_of :content_type, 
  #                    :with => /^audio/, 
  #                    :message => "Só é possível enviar ficheiros áudio"  
  
  
  def file=(incoming_file)
    self.content_type = incoming_file.content_type.chomp
    self.filename = APP_CONFIG[:folder] + '/' + uuid_name + File.extname(incoming_file.original_filename)
    File.open(self.filename, "w") do |file|
      file.write(incoming_file.read)
    end
  end
  
  def location
    '/' + APP_CONFIG[:folder_url] + '/' + File.basename(self.filename)
  end
  
  private 
  
  def delete_file
    File.delete(self.filename)  
  end
  
end
