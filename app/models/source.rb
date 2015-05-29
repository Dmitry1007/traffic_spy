module TrafficSpy
  class Source < ActiveRecord::Base
    validates_presence_of :identifier, :root_url
    validates :identifier, uniqueness: true
    has_many :payloads

    def urls
      payloads.map { |payload| payload.url }
    end

    def user_agents
      payloads.map { |payload| payload.user_agent }
    end
  end
end
