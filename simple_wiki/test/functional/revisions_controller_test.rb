require 'test_helper'

class RevisionsControllerTest < ActionController::TestCase
  def test_show
    page = pages(:rails)
    page.update_attributes :title => "Changed"
    
    get :show, :page_id => page.to_param, :id => 1
    assert_response :success
  end
end
