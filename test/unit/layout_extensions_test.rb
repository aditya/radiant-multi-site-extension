require File.dirname(__FILE__) + '/../test_helper'

class LayoutExtensionsTest < Test::Unit::TestCase
  fixtures :sites
  
  def setup
    @layout = Layout.new(:site => sites(:one))
  end

  def test_should_add_instance_methods
    assert_respond_to @layout, :site
  end
end
