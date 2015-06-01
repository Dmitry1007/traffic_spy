require 'uri'

module TrafficSpy
  class Dashboard
  attr_reader :source
  
    def initialize(source)
      @source = source
    end
    
    def identifier
      source.identifier
    end
  
    def payloads
      source.payloads
    end
    
    def url_view
      if source
        :dashboard
      else
        :identifier_error
      end
    end
  
    def event_view
      if source.payloads.map{ |payload| payload[:event_name] }.empty?
        :event_error
      else
        :eventpage_individual
      end
    end
    
    def urls_sorted
      payloads.group(:url).order('count_url desc').count(:url)
    end
    
    def breakdown_of_browser
      payloads.group(:browser).order('count_browser desc').count(:browser)
    end
    
    def breakdown_of_operating_system
      payloads.group(:operating_system).order('count_operating_system desc').count(:operating_system)
    end
    
    def breakdown_of_resolution
      payloads.group(:resolution).order('count_resolution desc').count(:resolution)
    end
    
    def breakdown_of_avg_url_response_times
      payloads.group(:url).order('average_responded_in desc').average(:responded_in)
    end
    
    def url_path(url)
      uri = URI(url)
      "/sources/#{source.identifier}/urls/#{uri.path}"
    end
    
    def events_sorted
      payloads.group(:event_name).order('event_name desc').count(:event_name)
    end

    def event_path(event)
      "/sources/#{source.identifier}/events/#{event}"
    end
  end
end
