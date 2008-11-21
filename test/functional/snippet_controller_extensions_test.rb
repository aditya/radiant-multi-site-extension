require File.dirname(__FILE__) + '/../test_helper'

class SnippetControllerExtensionsTest < Test::Unit::TestCase
  fixtures :sites, :pages
  test_helper :login
  
  def setup
    @controller = Admin::SnippetController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end
  
  def test_should_prevent_access
    login_as(:existing)
    get :index
    assert_response :redirect
    assert_redirected_to :controller => "admin/page"
    assert_equal "You must have developer privileges to perform this action.", flash[:error]
  end
  
  def test_should_allow_developer_access
    login_as(:developer)
    get :index
    assert_response :success
  end
end
