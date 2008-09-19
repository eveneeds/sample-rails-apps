require 'test_helper'

class IndexControllerTest < ActionController::TestCase
  def test_restricted_access
    get :index
    assert_redirected_to login_path
  end
  
  def test_works_when_logged_in
    login_as :leethal
    get :index
    assert_response :success
    assert_template 'index/index'
  end
end
