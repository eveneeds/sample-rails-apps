require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @post = posts(:jquery)
  end

  def test_previewing_invalid
    post :create, :post_id => @post.to_param, :preview => "Whatever"
    assert !assigns(:comment).valid?
    assert_template 'comments/show'
  end
  
  def test_previewing_valid
    post :create, :post_id => @post.to_param, :preview => "Whatever", :comment => {:text => "This is the comment"}
    assert assigns(:comment).valid?
    assert_template 'comments/show'
  end
  
  def test_successfull_create
    post :create, :post_id => @post.to_param, :comment => {:text => 'This is the comment.'}
    assert_redirected_to post_path(@post, :anchor => 'comments')
  end
  
  def test_failing_create
    post :create, :post_id => @post.to_param, :comment => {}
    assert_template 'posts/show'
  end
  
  def test_successfull_create_as_js
    post :create, :post_id => @post.to_param, :comment => {:text => 'This is the comment.'}, :format => "js"
  end
end
