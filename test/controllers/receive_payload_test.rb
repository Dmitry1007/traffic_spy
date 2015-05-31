require './test/test_helper'

class ReceivePayloadTest < ControllerTest
  
  def setup
    @valid_payload = 'payload={
        "url":"http://jumpstartlab.com/blog",
        "requestedAt":"2013-02-16 21:38:28 -0700",
        "respondedIn":37,
        "referredBy":"http://jumpstartlab.com",
        "requestType":"GET",
        "parameters":[],
        "eventName": "socialLogin",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"63.29.38.211"
    }'
    @invalid_payload = ''
  end

  def test_it_can_successfully_create_a_payload_row
    initial_count = TrafficSpy::Payload.count
    
    post '/sources/jumpstartlab/data', @valid_payload

    final_count   = TrafficSpy::Payload.count

    assert_equal 200, last_response.status
    assert_equal 1, (final_count - initial_count)
    assert_equal 1, TrafficSpy::Payload.first.id
  end

  def test_it_returns_a_403_error_when_the_url_path_is_invalid
    initial_count = TrafficSpy::Payload.count

    post '/sources/jumpstartlab/notarealpath', @invalid_payload

    final_count   = TrafficSpy::Payload.count

    assert_equal 403, last_response.status
    assert_equal "That application url does not exist", last_response.body
    assert_equal 0, (final_count - initial_count)
  end
  
  def test_it_returns_a_403_error_when_the_payload_request_has_already_been_received
    initial_count = TrafficSpy::Payload.count
    
    post '/sources/jumpstartlab/data', @valid_payload
    post '/sources/jumpstartlab/data', @valid_payload
    
    final_count = TrafficSpy::Payload.count
    
    assert_equal 403, last_response.status
    assert_equal "This payload has already been taken", last_response.body
    assert_equal 1, (final_count - initial_count)
  end
  
  def test_it_returns_a_400_error_when_the_payload_is_missing_information
    initial_count = TrafficSpy::Payload.count
    
    post '/sources/jumpstartlab/data', @invalid_payload
    
    final_count = TrafficSpy::Payload.count
    
    assert_equal 400, last_response.status
    assert_equal "Payload cannot be empty", last_response.body
    assert_equal 0, (final_count - initial_count)
  end
end
