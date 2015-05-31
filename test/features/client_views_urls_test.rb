require_relative '../test_helper'

class ClientViewsUrlsTest < FeatureTest
  def test_dashboard_exists_for_a_known_source
    create_source("jumpstartlab", "http=>//jumpstartlab.com")
    visit '/sources/jumpstartlab'

    assert page.has_content? "Welcome to TrafficSpy"
  end

  def test_dashboard_includes_urls_from_known_source
    create_source("jumpstartlab", "http=>//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "http://jumpstartlab.com/blog : 1 request(s)"
  end

  def test_dashboard_includes_web_browser_breakdown
    create_source("jumpstartlab", "http=>//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "Chrome 24.0.1309 : 1 time(s)"
  end

  def test_dashboard_includes_operating_system_breakdown
    create_source("jumpstartlab", "http=>//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "Mac OS X 10.8.2 : 1 time(s)"
  end

  def test_dashboard_includes_resolution_breakdown
    create_source("jumpstartlab", "http=>//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "1920 x 1280 : 1 time(s)"
  end

  def test_dashboard_includes_average_response_time
    create_source("jumpstartlab", "http=>//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "http://jumpstartlab.com/blog had an average response time of 37 seconds"
  end



end
