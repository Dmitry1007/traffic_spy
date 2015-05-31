require_relative '../test_helper'

class ClientViewsUrlsTest < FeatureTest
  
  def test_a_dashboard_exists_for_a_known_source
    create_source("jumpstartlab", "http://jumpstartlab.com")
    visit '/sources/jumpstartlab'
    
    assert page.has_content? "Welcome to TrafficSpy!"
  end
  
  def test_a_dashboard_includes_the_urls_from_a_known_source
    source = TrafficSpy::Source.create({:identifier => "jumpstartlab", :root_url => "http://jumpstartlab.com"})

      source.payloads.create({ 
      :url => TrafficSpy::Url.create(url: "http://jumpstartlab.com/blog"),
      :requested_at => "2013-02-16 21:38:28 -0700",
      :responded_in => 37,
      :referred_by => "http://jumpstartlab.com",
      :request_type => "GET",
      :event_name => "socialLogin",
      # :user_agent => TrafficSpy::UserAgent.create(user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"),
      :resolution_width => "1920",
      :resolution_height => "1280",
      :ip => "63.29.38.211",
      :sha => "4857"})

    # puts s.errors.full_messages
    visit '/sources/jumpstartlab'
    # save_and_open_page
    assert page.has_content? "http://jumpstartlab.com/blog"
  end
end
