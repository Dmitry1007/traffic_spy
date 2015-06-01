require_relative '../test_helper'

class ClientViewsUrlsTest < FeatureTest
  def test_dashboard_exists_for_a_known_source
    create_source("jumpstartlab", "http//jumpstartlab.com")
    visit '/sources/jumpstartlab'

    assert page.has_content? "Welcome to TrafficSpy"
  end
  
  def test_error_page_for_unregistered_source
    create_source("jumpstartlab", "http//jumpstartlab.com")
    visit '/sources/unregistered'
    
    assert page.has_content? "Well, that wasn't supposed to happen!"
  end

  def test_dashboard_includes_urls_from_known_source
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "http://jumpstartlab.com/blog : 3 request(s)"
  end

  def test_dashboard_includes_web_browser_breakdown
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "Chrome 24.0.1309"
  end

  def test_dashboard_includes_operating_system_breakdown
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "Mac OS X 10.8.2"
  end

  def test_dashboard_includes_resolution_breakdown
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "1920 x 1280 : 1 time(s)"
  end

  def test_dashboard_includes_average_response_time
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    assert page.has_content? "http://jumpstartlab.com/blog had an average response time of 36 seconds"
  end

  def test_url_breakdown_link_is_present

    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    find('.url-breakdown-link')
  end

  def test_url_breakdown_link_displays_breakdown_information_for_that_url

    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    find('.url-breakdown-link', visible: false).click

    assert page.has_content? "Longest response time:"
    assert page.has_content? "Shortest response time:"
    assert page.has_content? "Average response time:"
    assert page.has_content? "HTTP verbs used:"
    assert page.has_content? "Most popular referrers:"
    assert page.has_content? "Most popular browsers"
    assert page.has_content? "Most popular operating systems"
  end

  def test_url_average_response_link_is_present

    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'
    find('.url-average-response-link')
  end

  def test_url_averages_link_displays_average_information_for_that_url

    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab'

    find('.url-average-response-link', visible: false).click

    assert page.has_content? "Longest response time:"
    assert page.has_content? "Shortest response time:"
    assert page.has_content? "Average response time:"
    assert page.has_content? "HTTP verbs used:"
    assert page.has_content? "Most popular referrers:"
    assert page.has_content? "Most popular browsers"
    assert page.has_content? "Most popular operating systems"
  end
end

