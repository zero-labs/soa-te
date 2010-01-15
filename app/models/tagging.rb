class Tagging < ActiveRecord::Base
  belongs_to :sound
  belongs_to :tag
  
  validates_presence_of :sound
  validates_presence_of :tag
  
  validates_associated :sound
  validates_associated :tag
end
