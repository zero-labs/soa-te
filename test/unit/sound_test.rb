#
# Developed by Daniel Zacarias for Radio Zero
# E-mail: zacarias@radiozero.pt
# Web: http://www.radiozero.pt
#

require File.dirname(__FILE__) + '/../test_helper'

class SoundTest < Test::Unit::TestCase
  fixtures :sounds

  def test_valid_with_everything_correct
    sound = Sound.new(:title => 'test1', :latitude => 2.1, :longitude => 1.2 )
    assert sound.save                  
    sound = Sound.new(:title => 'test2', :latitude => '2.1', :longitude => 1.2 )
    assert sound.save                  
    sound = Sound.new(:title => 'test3', :latitude => 2.1, :longitude => '1.2' )
    assert sound.save                  
    sound = Sound.new(:title => 'test4', :latitude => '2.1', :longitude => '1.2' )
    assert sound.save
  end
  
  def test_invalid_without_coordinates
    sound = Sound.new(:title => 'test', :longitude => 1.2 )
    assert !sound.save                
    sound = Sound.new(:title => 'test', :latitude => 2.1)
    assert !sound.save                
    sound = Sound.new(:title => 'test')
    assert !sound.save
  end
  
  def test_invalid_with_invalid_coords
    sound = Sound.new(:title => 'test', :latitude => 'ola', :longitude => 1.2 )
    assert !sound.save                
    sound = Sound.new(:title => 'test', :latitude => 2.1, :longitude => 'mundo' )
    assert !sound.save                
    sound = Sound.new(:title => 'test', :latitude => 'ola', :longitude => 'mundo' )
    assert !sound.save
  end
  
  def test_invalid_without_title
    sound = sounds(:sound_without_title)
    assert !sound.save
  end
  
  def test_tagging_through_sound
    sound = sounds(:normal_sound)
    sound.tags = "a, tag, is, something, useful"
    assert sound.save
    sound = Sound.new(:title => 'title', :tags => ',, hello') # it should ignore badly formed tags
    assert sound.save
  end
  
end
