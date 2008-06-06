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
  
  def test_history
    get :history, :id => pages(:rails).to_param
    assert_response :success
  end
  
  def test_edit
    get :edit, :id => pages(:rails).to_param
    assert_response :success
  end
  
  def test_successful_update
    new_title = 'New title it has!'
    post :update, :id => pages(:rails).to_param, :page => {:message => 'Yeah', :title => new_title}
    assert_equal new_title, assigns(:page).title
    assert_redirected_to page_path(pages(:rails).to_param)
  end
  
  def test_failed_update
    post :update, :id => pages(:rails).to_param, :page => {:title => nil}
    assert_template 'pages/edit'
  end
end
