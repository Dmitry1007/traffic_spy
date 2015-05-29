module TrafficSpy
  class Source < ActiveRecord::Base
    validates_presence_of :identifier, :root_url
    validates :identifier, uniqueness: true
    has_many :payloads
    
    def browsers
      UserAgentParser.parse(params)
    end

    def urls
      # binding.pry
      payloads.map { |payload| payload.url }
    end
  end
end
