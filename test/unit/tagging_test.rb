require File.dirname(__FILE__) + '/../test_helper'

class TaggingTest < Test::Unit::TestCase
  fixtures :taggings, :sounds, :tags

  def test_valid_w_everything_valid
    sound = sounds(:normal_sound)
    tagging = taggings(:valid_tagging_1)
    assert tagging.save
    tagging = taggings(:valid_tagging_2)
    assert tagging.save
    tagging = taggings(:valid_tagging_3)
    assert tagging.save
  end
  
  def test_invalid_w_invalid_fields
    tagging = taggings(:invalid_tagging_w_bad_tag)
    assert !tagging.save
    tagging = taggings(:invalid_tagging_w_bad_sound)
    assert !tagging.save
  end
end
