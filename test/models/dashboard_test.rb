require_relative '../test_helper'

class DashboardTest < ModelTest
  
  def test_it_can_return_its_identifier
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    
    assert_equal "jumpstartlab", source.identifier
  end
  
  def test_it_can_return_its_payloads
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads
    
    assert_equal 1, source.payloads.first.id
    assert_equal 3, source.payloads.count
  end
  
  def test_it_can_return_its_sorted_urls
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads
    
    assert_equal Hash, source.payloads.group(:url).order('count_url desc').count(:url).class
    assert_equal "{\"http://jumpstartlab.com/blog\":3}", source.payloads.group(:url).order('count_url desc').count(:url).to_json
  end
  
  def test_it_can_return_a_browser_breakdown
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal Hash, source.payloads.group(:browser).order('count_browser desc').count(:browser).class
    assert_equal "{\"Chrome 24.0.1309\":2,\"Chrome 22.0.1309\":1}", source.payloads.group(:browser).order('count_browser desc').count(:browser).to_json
  end
  
  def test_it_can_return_an_operating_system_breakdown
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads

    assert_equal Hash, source.payloads.group(:operating_system).order('count_operating_system desc').count(:operating_system).class
    assert_equal "{\"Mac OS X 10.8.2\":2,\"Mac OS X 10.8.1\":1}", source.payloads.group(:operating_system).order('count_operating_system desc').count(:operating_system).to_json
  end
  
  def test_it_can_return_a_resolution_breakdown
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads
    
    assert_equal Hash, source.payloads.group(:resolution).order('count_resolution desc').count(:resolution).class
    assert_equal "{\"1920 x 1280\":1,\"1640 x 1480\":1,\"1240 x 1860\":1}", source.payloads.group(:resolution).order('count_resolution desc').count(:resolution).to_json
  end
  
  def test_it_can_return_an_avg_response_times_breakdown
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads
    
    assert_equal Hash, source.payloads.group(:url).order('average_responded_in desc').average(:responded_in).class
    assert_equal "{\"http://jumpstartlab.com/blog\":\"36.0\"}", source.payloads.group(:url).order('average_responded_in desc').average(:responded_in).to_json
  end
  
  def test_it_can_return_sorted_events
    source = create_source("jumpstartlab", "http://jumpstartlab.com")
    create_payloads
    
    assert_equal Hash, source.payloads.group(:event_name).order('event_name desc').count(:event_name).class
    assert_equal "{\"socialLogin\":3}", source.payloads.group(:event_name).order('event_name desc').count(:event_name).to_json
  end
end
