require 'digest/sha1'
require 'useragent'

module TrafficSpy
  class ParsePayload
    attr_accessor :status, :body
    
    def initialize(json_params, source)
      parse(json_params, source)
    end
    
    
    def parse(json_params, source)
      
    end
    
    def validate
      if params.blank?
        @status = 400
        @body = "Payload cannot be empty"
      else
        parsed_params = JSON.parse(params)
        @payload = Payload.new(requested_at:      parsed_params["requestedAt"],
                               responded_in:      RespondedIn.find_or_create_by(responded_in: parsed_params["respondedIn"]),
                               referred_by:       parsed_params["referredBy"],
                               request_type:      parsed_params["requestType"],
                               event_name:        parsed_params["eventName"],
                               resolution_width:  parsed_params["resolutionWidth"],
                               resolution_height: parsed_params["resolutionHeight"],
                               ip:                parsed_params["ip"],
                               sha:               Digest::SHA1.hexdigest(params),
                               url:               Url.find_or_create_by(url: parsed_params["url"]))
        if @payload.save

          @status = 200
        else
          @status = 403
          @body = "This payload has already been taken"
        end
      end
      self
    end


  end
end
