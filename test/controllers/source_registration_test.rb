require './test/test_helper'

class RegistrationTest < ControllerTest

  def test_a_request_can_be_submitted_with_all_fields
    original_count = TrafficSpy::Source.count
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    source = TrafficSpy::Source.first
    final_count = TrafficSpy::Source.count
  
    assert_equal "jumpstartlab", source.identifier
    assert_equal "http://jumpstartlab.com", source.root_url
    
    assert_equal 200, last_response.status
    assert_equal "{\"identifier\":\"jumpstartlab\"}", last_response.body
    assert_equal 1, (final_count - original_count)
  end

  def test_403_error_when_the_identifier_already_exists
    TrafficSpy::Source.create(identifier: "jumpstartlab", root_url: "http://jumpstartlab.com")
    original_count = TrafficSpy::Source.count
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'

    assert_equal original_count, TrafficSpy::Source.count
    assert_equal 403, last_response.status
    assert_equal "That identifier is already in use", last_response.body
  end

  def test_400_error_when_source_is_empty
    original_count = TrafficSpy::Source.count
    post '/sources', ''

    assert_equal original_count, TrafficSpy::Source.count
    assert_equal 400, last_response.status
    assert_equal "Please enter an identifier and a root url", last_response.body
  end
  
  def test_400_error_when_identifier_is_empty
    original_count = TrafficSpy::Source.count
    post '/sources', 'rootUrl=http://jumpstartlab.com'
    
    assert_equal original_count, TrafficSpy::Source.count
    assert_equal 400, last_response.status
    assert_equal "Please enter an identifier", last_response.body
  end

  def test_400_error_when_root_url_is_empty
    original_count = TrafficSpy::Source.count
    post '/sources', 'identifier=jumpstartlab'

    assert_equal original_count, TrafficSpy::Source.count
    assert_equal 400, last_response.status
    assert_equal "Please enter a root url", last_response.body
  end
end
