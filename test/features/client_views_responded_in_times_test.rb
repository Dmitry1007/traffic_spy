require_relative '../test_helper'

class RespondedInTest < FeatureTest
  def test_it_displays_response_information_in_browser

    source = TrafficSpy::Source.create({:identifier => "jumpstartlab", :root_url => "http://jumpstartlab.com"})

    source.payloads.create({
      :url => TrafficSpy::Url.create(url: "http://jumpstartlab.com/blog"),
      :requested_at => "2013-02-16 21:38:28 -0700",
      :responded_in => TrafficSpy::RespondedIn.create(responded_in: 37),
      :referred_by => "http://jumpstartlab.com",
      :request_type => "GET",
      :event_name => "socialLogin",
      :user_agent => TrafficSpy::UserAgent.create(user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"),
       :resolution_width => "1920",
       :resolution_height => "1280",
       :ip => "63.29.38.211",
       :sha => "4857"})


  visit '/sources/jumpstartlab'
  assert page.has_content? 37
  end

end

=begin

User Story:
As a client
When I visit http://yourapplication:port/sources/IDENTIFIER, where IDENTIFIER is my unique pre-established identifier
I can view Longest, average response time per URL to shortest, average response time per URL

=end
