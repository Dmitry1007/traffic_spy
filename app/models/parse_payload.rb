module TrafficSpy
  class ParsePayload
    def initialize(params)
      parse = JSON.parse(params)
      @payload = Payload.new(url:               parse["url"],
                             requested_at:      parse["requestedAt"],
                             responded_in:      parse["respondedIn"],
                             referred_by:       parse["referredBy"],
                             request_type:      parse["requestType"],
                             event_name:        parse["eventName"],
                             user_agent:        parse["userAgent"],
                             resolution_width:  parse["resolutionWidth"],
                             resolution_height: parse["resolutionHeight"],
                             ip:                parse["ip"])
      @payload.save
    end
  end
end
