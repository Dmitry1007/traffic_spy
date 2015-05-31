require 'json'
require 'digest/sha1'
require 'user_agent_parser'

module TrafficSpy
  class ParsePayload
    attr_accessor :status, :body
    
    def initialize(json_params, source)
      parse(json_params, source)
    end
    
    def parse(json_params, source)
      if established_source?(source)
        parse_payload(json_params, source)
      else
        @status = 403
        @body = "Unregistered source" 
      end
    end
    
    def established_source?(source)
      Source.exists?(identifier: source.identifier) if source
    end
    
    def parse_json(json_params)
      JSON.parse(json_params)
    end

    def parse_user_agent(user_agent)
      UserAgentParser.parse(user_agent)
    end
    
    def establish_sha(some_string)
      Digest::SHA1.hexdigest(some_string) if some_string
    end
    
    def parse_payload(json_params, source)
      sha = establish_sha(json_params)
      json_params ? payload_data = parse_json(json_params) : payload_data = {}
      user_agent = parse_user_agent(payload_data["userAgent"])
      payload = Payload.new(url: payload_data["url"], # same as 'source.payloads.new'
        sha:sha,
        source_id: source.id,
        responded_in: payload_data["respondedIn"],
        resolution: "#{payload_data["resolutionWidth"]} x #{payload_data["resolutionHeight"]}",
        browser: user_agent.to_s,
        operating_system: user_agent.os.to_s,
        requested_at: payload_data["requestedAt"],
        request_type: payload_data["requestType"],
        referred_by: payload_data["referredBy"],
        event_name: payload_data["eventName"]
      )
      payload.save ? @status = 200 : review(payload, sha)
    end
    
    def review(payload, sha)
      if payload.url == nil #perhaps not the best way to do this?
        @status = 400
        @body = "Payload cannot be empty"
      elsif
        Payload.exists?(sha: sha)
        @status = 403
        @body = "This payload has already been received"
      end
    end
  end
end
