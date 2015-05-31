require_relative '../test_helper'

class ClientViewsUserAgentTest < FeatureTest

  # def test_it_displays_the_type_of_browser_to_user
  #   # pull the user_agent data
  #   # parse that data with user_agent parser
  #   # save browser info to user_agent table (browser)
  #   source = TrafficSpy::Source.create({:identifier => "jumpstartlab", :root_url => "http://jumpstartlab.com"})
  # 
  #     source.payloads.create({
  #     :url => TrafficSpy::Url.create(url: "http://jumpstartlab.com/blog"),
  #     :requested_at => "2013-02-16 21:38:28 -0700",
  #     :responded_in => 37,
  #     :referred_by => "http://jumpstartlab.com",
  #     :request_type => "GET",
  #     :event_name => "socialLogin",
  #     :user_agent => TrafficSpy::UserAgent.create(user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"),
  #     :resolution_width => "1920",
  #     :resolution_height => "1280",
  #     :ip => "63.29.38.211",
  #     :sha => "4857"})
  #   
  #   visit '/sources/jumpstartlab'
  #   assert page.has_content? "Chrome 24.0.1309"
  #   assert page.has_content? "Mac OS X 10.8.2"
  # end

end

# As a client
# When I visit http://yourapplication:port/sources/IDENTIFIER, 
# where IDENTIFIER is my unique pre-established identifier
# I can view Web browser breakdown across all requests (userAgent) 
# and OS breakdown across all requests (userAgent)
