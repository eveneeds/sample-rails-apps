require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_getting_new
    get :new
    assert_response :success
    assert_template 'sessions/new'
  end
  
  def test_successful_login
    post :create, :username => 'leethal', :password => '12345'
    assert_redirected_to root_path
    assert @controller.logged_in?
  end
  
  def test_failed_login
    post :create, :username => 'noway', :password => 'srsly'
    assert_response :success
    assert_template 'sessions/new'
    assert !@controller.logged_in?
  end
  
  def test_logout
    post :create, :username => 'leethal', :password => '12345'
    assert @controller.logged_in?
    
    post :destroy
    assert_redirected_to login_path
    assert !@controller.logged_in?
  end
end
