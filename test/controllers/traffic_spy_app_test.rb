require './test/test_helper'

class RegistrationTest < ControllerTest

  def test_it_can_successfully_register_a_client
    initial_count = TrafficSpy::Client.count
    post '/sources', { client: {identifier: "jumpstartlab", rootUrl: "http://jumpstartlab.com"} }
    final_count   = TrafficSpy::Client.count
    assert_equal 200, last_response.status
    assert_equal "Registration Successful", last_response.body
    assert_equal 1, (final_count - initial_count)
  end
end