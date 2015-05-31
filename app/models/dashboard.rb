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
    
    def sorted_urls
      source.payloads.group(:url).order('count_url desc').count(:url)
    end
  end
end
