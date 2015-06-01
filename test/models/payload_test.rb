require_relative '../test_helper'

class PayloadTest < ModelTest
  
  def test_it_assigns_attributes_correctly
    data = {url: "http://jumpstartlab.com/blog",
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
    payload = TrafficSpy::Payload.new(data)
    
    assert_equal "http://jumpstartlab.com/blog", payload.url
    assert_equal 1234,                           payload.sha
    assert_equal 1,                              payload.source_id
    assert_equal 37,                             payload.responded_in
    assert_equal "1920 x 1280",                  payload.resolution
    assert_equal "Chrome 24.0.1309",             payload.browser
    assert_equal "Mac OS X 10.8.2",              payload.operating_system
    assert_equal "2013-02-16 21:38:28 -0700",    payload.requested_at
    assert_equal "GET",                          payload.request_type
    assert_equal "http://jumpstartlab.com",      payload.referred_by
    assert_equal "socialLogin",                  payload.event_name
  end
end
