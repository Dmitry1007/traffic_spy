require_relative '../test_helper'

class SourceTest < ModelTest

  def test_it_assigns_attributes_correctly
    data = {identifier: "jumpstartlab",
            root_url:   "http://jumpstartlab.com"}
      
    source = TrafficSpy::Source.new(data)

    assert_equal "jumpstartlab",            source.identifier
    assert_equal "http://jumpstartlab.com", source.root_url
  end
end
