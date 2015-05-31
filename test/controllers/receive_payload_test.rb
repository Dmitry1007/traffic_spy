require './test/test_helper'

class ReceivePayloadTest < ControllerTest

  def test_it_can_successfully_create_a_payload_for_a_registered_source
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    post 'sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    assert_equal 200, last_response.status
  end

  def test_it_returns_a_403_error_when_it_receives_a_payload_from_an_unregistered_source
    initial_count = TrafficSpy::Payload.count
    
    post 'sources/random/data', 'payload={"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com",
      "requestType":"GET","parameters":[],"eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    
    final_count = TrafficSpy::Payload.count
    
    assert_equal 403, last_response.status
    assert_equal "URL not recognized", last_response.body
    assert_equal 0, final_count - initial_count
  end
  
  def test_it_returns_a_403_error_when_the_payload_request_has_already_been_received
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    post 'sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com",
      "requestType":"GET","parameters":[],"eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'

    initial_count = TrafficSpy::Payload.count
    
    post 'sources/jumpstartlab/data', 'payload={"url":"http://jumpstartlab.com/blog",
      "requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com",
      "requestType":"GET","parameters":[],"eventName":"socialLogin",
      "userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
      "resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}'
    
    final_count = TrafficSpy::Payload.count
    
    assert_equal 403, last_response.status
    assert_equal "This payload has already been received", last_response.body
    assert_equal 0, final_count - initial_count
  end
  
  def test_it_returns_a_400_error_when_the_payload_is_misidentified
    post '/sources', { identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com" }

    initial_count = TrafficSpy::Payload.count
    post 'sources/jumpstartlab/data', {}
    final_count = TrafficSpy::Payload.count
    
    assert_equal 400, last_response.status
    assert_equal "Payload cannot be empty", last_response.body
    assert_equal 0, (final_count - initial_count)
  end
end
