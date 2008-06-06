require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def test_home
    get :index
    assert_response :success
    assert_equal Page.home, assigns(:page)
  end
  
  def test_no_pages
    Page.delete_all
    get :index
    assert_template 'no_page'
  end
end
