require_relative '../test_helper'

class ClientViewsUrlsTest < FeatureTest
  
  def test_a_dashboard_exists_for_a_known_source
    create_source("jumpstartlab", "http=>//jumpstartlab.com")
    visit '/sources/jumpstartlab'
    
    assert page.has_content? "Welcome to TrafficSpy!"
  end
  
  def test_a_dashboard_includes_the_urls_from_a_known_source
    source = TrafficSpy::Source.create({:identifier => "jumpstartlab", :root_url => "http=>//jumpstartlab.com"})
    source.payloads.create({
        "url" => "http=>//jumpstartlab.com/blog",
        "requested_at" => "2013-02-16 21=>38=>28 -0700",
        "responded_in" => 37,
        "referred_by" => "http=>//jumpstartlab.com",
        "request_type" => "GET",
        "event_name" => "socialLogin",
        "browser" => "Mozilla/5.0",
        "operating_system" => "",
        "resolution" => "1920 x 1280",
        "sha" => "123456"
      })
    visit '/sources/jumpstartlab'
    
    assert page.has_content? "http=>//jumpstartlab.com/blog"
  end
  
  def test_the_user_sees_the_identifier_error_page_if_they_havent_registered
    create_source("jumpstartlab", "http=>//jumpstartlab.com")
    visit '/sources/nopenotanidentifier'

    assert page.has_content? "The identifier you're using hasn't been registered!"
  end
end
