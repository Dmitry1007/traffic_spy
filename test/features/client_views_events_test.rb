require_relative '../test_helper'

class ClientViewsEventsTest < FeatureTest
  def test_event_page_exists
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab/events'
  
    assert page.has_content? "Event breakdown"
  end

  def test_event_page_has_event_links
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab/events'

    assert find_link('socialLogin')
  end
  
  def test_event_link_works
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab/events'
    click_link('socialLogin')

    assert page.has_content? 'Hourly event breakdown:'
    assert page.has_content? 'Number of times received:'
  end
  
  def test_event_error_page_for_nonexistent_events
    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab/events/fakeevent'
  
    assert page.has_content? "Well, that wasn't supposed to happen!"
    assert page.has_content? "There aren't any"
  end
  
  def test_return_to_index_page_link_exists_on_error_page

    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab/events/fakeevent'

    assert find('.event-redirect', visible: false)
  end
  
  def test_the_return_to_index_page_returns_user_to_events_index

    create_source("jumpstartlab", "http//jumpstartlab.com")
    create_payloads
    visit '/sources/jumpstartlab/events/fakeevent'
    find('.event-redirect', visible: false).click

    assert page.has_content? "Event breakdown"

  end
end
