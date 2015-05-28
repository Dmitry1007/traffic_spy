module TrafficSpy
  class Payload < ActiveRecord::Base
    validates :url, presence: true
    
    def to_h
      {
        url: self.url,
        requestedAt: self.requestedAt,
        
      }
    end
  end
end
