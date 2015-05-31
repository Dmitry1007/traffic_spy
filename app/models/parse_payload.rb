require 'json'
require 'digest/sha1'
require 'useragent'

module TrafficSpy
  class ParsePayload
    attr_accessor :status, :body
    
    def initialize(json_params, source)
      parse(json_params, source)
    end
    
    def parse(json_params, source)
      if established_source?(source)
        parse_payload(json_params)
      end
    end
    
    def established_source?(source)
      Source.exists?(identifier: source.identifier) if source
    end
    
    def parse_json(json_params)
      JSON.parse(json_params)
    end
    
    def establish_sha(some_string)
      Digest::SHA1.hexdigest(some_string) if some_string
    end
    
    def parse_payload(json_params)
      sha = establish_sha(json_params)
      json_params ? data = parse_json(json_params) : data = {}
      user_agent = UserAgent.parse(data["userAgent"])
      payload = Payload.new(url: data["url"], # source.payloads.new
        sha:sha,
        source_id: source.id,
        responded_in: data["respondedIn"],
        resolution: "#{data['resolutionWidth']} x #{data['resolutionHeight']}",
        browser: user_agent.browser,
        operating_system: user_agent.platform,
        requested_at: data["requestedAt"],
        request_type: data["requestType"],
        referred_by: data["referredBy"],
        event_name: data["eventName"]
      )
      payload.save ? @status = 200 : review(payload, sha)
    end
    
    def review(payload, sha)
      if payload.url == nil
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
