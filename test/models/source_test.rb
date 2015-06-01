require_relative '../test_helper'

class SourceTest < ModelTest

  def test_it_assigns_attributes_correctly
    data = {identifier: "jumpstartlab",
            root_url:   "http://jumpstartlab.com"}
      
    source = TrafficSpy::Source.new(data)

    assert_equal "jumpstartlab",            source.identifier
    assert_equal "http://jumpstartlab.com", source.root_url
  end
  
  def test_it_can_return_its_urls
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    
    assert_equal ["http://jumpstartlab.com/blog", "http://jumpstartlab.com/blog", "http://jumpstartlab.com/blog"], source.urls
    assert_equal 3, source.urls.count
  end
  
  def test_it_can_returns_its_browsers
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    
    assert_equal ["Chrome 24.0.1309", "Chrome 22.0.1309", "Chrome 24.0.1309"], source.browsers
    assert_equal 3, source.browsers.count
  end

  def test_it_can_returns_its_operating_systems
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads

    assert_equal ["Mac OS X 10.8.2", "Mac OS X 10.8.2", "Mac OS X 10.8.1"], source.operating_systems
    assert_equal 3, source.operating_systems.count
  end
  
  def test_it_can_determine_a_path
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    
    assert_equal "http//jumpstartlab.com/blog", source.determine_path("blog")
  end
  
  def test_it_can_return_its_longest_response_time
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    
    assert_equal 42, source.payloads.where(url: "http://jumpstartlab.com/blog").maximum(:responded_in)
  end
  
  def test_it_can_return_its_shortest_response_time
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads

    assert_equal 29, source.payloads.where(url: "http://jumpstartlab.com/blog").minimum(:responded_in)
  end
  
  def test_it_can_return_its_average_response_time
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads

    assert_equal 36, source.payloads.where(url: "http://jumpstartlab.com/blog").average(:responded_in)
  end
  
  def test_it_can_return_the_http_verbs_used
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads

    assert_equal ["GET"], source.payloads.where(url: "http://jumpstartlab.com/blog").uniq.pluck(:request_type)
  end
  
  def test_it_can_return_its_top_three_referrers
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads

    assert_equal [["http://jumpstartlab.com", 3]], source.payloads.where(url: "http://jumpstartlab.com/blog").group(:referred_by).order('referred_by desc').count(:referred_by).first(3)
  end
  
  def test_it_can_return_its_top_three_browsers
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads

    assert_equal [["Chrome 24.0.1309", 2], ["Chrome 22.0.1309", 1]], source.payloads.where(url: "http://jumpstartlab.com/blog").group(:browser).order('browser desc').count(:browser).first(3)
  end
  
  def test_it_can_return_its_top_three_operating_systems
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads

    assert_equal [["Mac OS X 10.8.2", 2], ["Mac OS X 10.8.1", 1]], source.payloads.where(url: "http://jumpstartlab.com/blog").group(:operating_system).order('operating_system desc').count(:operating_system).first(3)
  end
  
  def test_it_can_return_its_event_names
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads

    assert_equal [["socialLogin", 3]], source.event_names
  end
  
  def test_it_can_return_total_events_received
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    event_name = "socialLogin"

    assert_equal 3, source.total_events_received(event_name)
  end
  
  def test_it_can_return_its_hourly_events
    source = create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    event_name = "socialLogin"

    assert_equal Hash, source.hourly_events(event_name).class
  end
end
