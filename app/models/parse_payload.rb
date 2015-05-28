module TrafficSpy
  class ParsePayload
    attr_reader :status, :body, :params
    
    def initialize(params)
      @status = nil
      @body = nil
      @params = params
    end
    
    def validate
      if params.blank?
        @status = 400
        @body = "Payload cannot be empty"
      else
        parsed_params = JSON.parse(params)
        @payload = Payload.new(url:               parsed_params["url"],
                               requested_at:      parsed_params["requestedAt"],
                               responded_in:      parsed_params["respondedIn"],
                               referred_by:       parsed_params["referredBy"],
                               request_type:      parsed_params["requestType"],
                               event_name:        parsed_params["eventName"],
                               user_agent:        parsed_params["userAgent"],
                               resolution_width:  parsed_params["resolutionWidth"],
                               resolution_height: parsed_params["resolutionHeight"],
                               ip:                parsed_params["ip"],
                               sha:               Digest::SHA1.hexdigest(params))
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
