File.join(File.dirname(__FILE__), '..', 'test_helper')

class PostsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_response :success
  end
  
  def test_successfull_show
    post = posts(:jquery)
    get :show, :id => post.to_param
    
    assert_response :success
    assert_equal post, assigns(:post)
  end
  
  def test_failing_show
    assert_raises(ActiveRecord::RecordNotFound) { get :show, :id => 666 }
  end
end
