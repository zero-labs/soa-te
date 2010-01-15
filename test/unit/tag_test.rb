require File.dirname(__FILE__) + '/../test_helper'

class TagTest < Test::Unit::TestCase
  fixtures :tags

  def test_valid_with_name
    tag = Tag.new(:name => 'test tag')
    assert tag.save
  end
  
  def test_invalid_without_name
    tag = Tag.new
    assert !tag.save
  end
  
  def test_name_uniqueness
    tag = tags(:valid_tag_2)
    good_tag = Tag.new(:name => tag.name + "_a_different_name")
    assert good_tag.save
    bad_tag = Tag.new(:name => tag.name)
    assert !bad_tag.save
  end
end
