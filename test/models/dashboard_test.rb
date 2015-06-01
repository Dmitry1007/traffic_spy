require_relative '../test_helper'

class DashboardTest < ModelTest
  
  def test_it_can_sort_urls
    create_payloads
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    dataset = Dashboard.new(source)
    
    assert_equal "", dataset.urls_sorted
  end
end
