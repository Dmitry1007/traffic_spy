require_relative '../test_helper'

class ParsePayloadTest < ModelTest
  
  def setup
    @data = {url: "http://jumpstartlab.com/blog",
             sha: 1234,
             source_id: 1,
             responded_in: 37,
             resolution: "1920 x 1280",
             browser: "Chrome 24.0.1309",
             operating_system: "Mac OS X 10.8.2",
             requested_at: "2013-02-16 21:38:28 -0700",
             request_type: "GET",
             referred_by: "http://jumpstartlab.com",
             event_name: "socialLogin"}
    @source = 
  end
  
  def test_it_can_parse_a_valid_payload
    parsed_payload = TrafficSpy::ParsePayload.new(@data, )
  end
end
