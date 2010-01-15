require File.dirname(__FILE__) + '/../test_helper'
require 'sounds_controller'

# Re-raise errors caught by the controller.
class SoundsController; def rescue_action(e) raise e end; end

class SoundsControllerTest < Test::Unit::TestCase
  fixtures :sounds

  def setup
    @controller = SoundsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert assigns(:sounds)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end
  
  def test_should_create_sound
    old_count = Sound.count
    post :create, :sound => { }
    assert_equal old_count+1, Sound.count
    
    assert_redirected_to sound_path(assigns(:sound))
  end

  def test_should_show_sound
    get :show, :id => 1
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => 1
    assert_response :success
  end
  
  def test_should_update_sound
    put :update, :id => 1, :sound => { }
    assert_redirected_to sound_path(assigns(:sound))
  end
  
  def test_should_destroy_sound
    old_count = Sound.count
    delete :destroy, :id => 1
    assert_equal old_count-1, Sound.count
    
    assert_redirected_to sounds_path
  end
end
