require_relative '../test_helper'

class ClientViewsUrlsTest < FeatureTest
  
  def test_a_dashboard_exists_for_a_known_source
    create_source("jumpstartlab", "http://jumpstartlab.com")
    visit '/sources/jumpstartlab'
    
    assert page.has_content? "Welcome to TrafficSpy!"
  end
  
  def test_a_dashboard_includes_the_urls_from_a_known_source
    TrafficSpy::Source.create({:identifier => "jumpstartlab", :root_url => "http://jumpstartlab.com"})

      raw_data = { "url" => "http://jumpstartlab.com/about",
      "requestedAt" => "2013-02-16 21:38:28 -0700",
      "respondedIn" => 37,
      "referredBy"=> "http://jumpstartlab.com",
      "requestType" => "GET",
      "parameters" => [],
      "eventName" => "socialLogin",
      "userAgent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth" => "1920",
      "resolutionHeight" => "1280",
      "ip" => "63.29.38.211"}
    
    TrafficSpy::ParsePayload.new(raw_data.to_json).validate
    visit '/sources/jumpstartlab'
    
    assert page.has_content? "http://jumpstartlab.com/about"
  end
end
