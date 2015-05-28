require './test/test_helper'

class RegistrationTest < ControllerTest

  def test_a_request_can_be_submitted_with_all_fields
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    s = TrafficSpy::Source.last
  
    assert_equal "jumpstartlab", s.identifier
    assert_equal "http://jumpstartlab.com", s.rootUrl
    
    assert_equal 200, last_response.status
    assert_equal "{'identifier':'jumpstartlab'}", last_response.body
  end
  
  def test_400_error_when_identifier_is_empty
    original_count = TrafficSpy::Source.count
    post '/sources', 'rootUrl=http://jumpstartlab.com'
    
    assert_equal original_count, TrafficSpy::Source.count
    
    assert_equal 400, last_response.status
    assert_equal "Identifier can't be blank", last_response.body
  end
  
  def test_400_error_when_root_url_is_empty
    original_count = TrafficSpy::Source.count
    post '/sources', 'identifier=jumpstartlab'
    
    assert_equal original_count, TrafficSpy::Source.count
    
    assert_equal 400, last_response.status
    assert_equal "Rooturl can't be blank", last_response.body
  end
  
  def test_403_error_when_the_identifier_already_exists
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    original_count = TrafficSpy::Source.count
    post '/sources', 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'
    
    assert_equal original_count, TrafficSpy::Source.count
    
    assert_equal 403, last_response.status
    assert_equal "Identifier has already been taken", last_response.body
  end
end

# As a user
# When I send a Post request to: http://yourapplication:port/sources
# parameters 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com
# Then I expect a 200 response with data as JSON {"identifier":"jumpstartlab"}

# As a user
# When I send a Post request to: http://yourapplication:port/sources
# parameters 'identifier=jumpstartlab'
# Then I expect a 400 response with "Please Provide an root url."

# def test_it_can_successfully_register_a_client
#     initial_count = TrafficSpy::Client.count
#     post '/sources', {client: {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"}}
#     final_count   = TrafficSpy::Client.count
#     assert_equal 200, last_response.status
#     assert_equal  "{\"identifier\":\"jumpstartlab\"}", last_response.body
#     assert_equal 1, (final_count - initial_count)
#   end
