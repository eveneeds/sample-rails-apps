require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = new_user
  end
  
  def test_new_user_valid
    assert @user.valid?
  end
  
  def test_password_required
    assert @user.instance_eval { password_required? }
    
    @user.save
    
    # Reload won't un-set the password attribute, so we gotta find it "from scratch"
    @user = User.find_by_username('foo')
    assert !@user.instance_eval { password_required? }
    
    @user.password = "setting a new password"
    assert @user.instance_eval { password_required? }
  end
  
  def test_password_length
    @user.password = "12"
    assert !@user.valid?
    
    @user.password = "12345"
    assert @user.valid?
  end
  
  def test_storing_the_password_hash
    @user.save
    assert @user.password_hash, 'It did not store the password hash to db'
    assert_equal 40, @user.password_hash.size
  end
  
  def test_authenticate
    assert User.authenticate('leethal', '12345')
    assert User.authenticate('leethal', '12345').is_a?(User)
    assert !User.authenticate('noway', 'odd')
  end
  
  private
  
  def new_user
    User.new(:username => "foo", :password => "12345")
  end
end
