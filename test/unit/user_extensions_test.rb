require File.dirname(__FILE__) + '/../test_helper'

class UserExtensionsTest < Test::Unit::TestCase
  fixtures :sites
  
  def setup
    @user = User.new(:site => sites(:one))
  end

  def test_should_add_instance_methods
    assert_respond_to @user, :site
    assert_respond_to @user, :owner?
  end
  
  def test_should_be_owner
    assert_equal @user.site, sites(:one)
    assert @user.owner?(sites(:one))
  end
end
