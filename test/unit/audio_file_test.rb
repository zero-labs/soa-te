require File.dirname(__FILE__) + '/../test_helper'

class AudioFileTest < Test::Unit::TestCase
  fixtures :audio_files, :sounds

  def test_valid_with_everything_correct
    sound = sounds(:normal_sound)
    audio_file = AudioFile.new(:filename => '/var/tmp/test.mp3', :sound => sound)
    assert audio_file.save
  end
  
  def test_invalid_with_no_filename
    sound = sounds(:normal_sound)
    audio_file = AudioFile.new(:sound => sound)
    assert !audio_file.save
  end
  
  def test_invalid_with_no_sound
    audio_file = AudioFile.new(:filename => 'test.mp3')
    assert !audio_file.save
  end
end
