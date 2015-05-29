require_relative '../test_helper'

class ClientViewsUrlsTest < FeatureTest
  
  def test_a_dashboard_exists_for_a_known_source
    create_source("jumpstartlab", "http://jumpstartlab.com")
    visit '/sources/jumpstartlab'
    
    assert page.has_content? "Welcome to TrafficSpy!"
  end
  
  def test_a_dashboard_includes_the_urls_from_a_known_source
    create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'
    
    assert page.has_content? ""
  end
end
