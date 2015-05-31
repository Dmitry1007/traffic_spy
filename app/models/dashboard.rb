module TrafficSpy
  class Dashboard
  attr_reader :source
  
    def initialize(source)
      @source = source
    end
    
    def identifier
      source.identifier
    end
    
    def view
      if source
        :dashboard
      else
        :identifier_error
      end
    end
    
    def urls_sorted
      source.payloads.group(:url).order('count_url desc').count(:url)
    end
    
    def breakdown_of_browser
      source.payloads.group(:browser).order('count_browser desc').count(:browser)
    end
    
    def breakdown_of_operating_system
      source.payloads.group(:operating_system).order('count_operating_system desc').count(:operating_system)
    end
    
    def breakdown_of_resolution
      source.payloads.group(:resolution).order('count_resolution desc').count(:resolution)
    end
    
    def breakdown_of_avg_url_response_times
      source.payloads.group(:url).order('average_responded_in desc').average(:responded_in)
    end
  end
end
