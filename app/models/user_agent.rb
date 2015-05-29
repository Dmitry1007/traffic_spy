require "user_agent_parser"

module TrafficSpy
  class UserAgent < ActiveRecord::Base
    has_many :payloads
    before_create :parse_browser
    before_create :parse_os

    def parse_browser
      self.browser = ::UserAgentParser.parse(user_agent).to_s
    end

    def parse_os
      self.operating_system = ::UserAgentParser.parse(user_agent).os.to_s
    end

  end
end