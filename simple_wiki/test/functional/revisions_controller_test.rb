require 'test_helper'

class RevisionsControllerTest < ActionController::TestCase
  def test_show
    page = pages(:rails)
    page.update_attributes :title => "Changed"
    
    get :show, :page_id => page.to_param, :id => 1
    assert_response :success
  end
  
  def test_finding_by_number_not_id
    # Creating revisions so that the primary key doesn't start at 1
    Page.create(:title => 'New page yay', :content => "yep").update_attributes(:title => "Edited totally liek")
    
    page = pages(:rails)
    page.update_attributes :title => "Changed"
    get :show, :page_id => page.to_param, :id => 1
    assert_response :success
    assert_equal page.latest_revision, assigns(:revision)
  end
end
