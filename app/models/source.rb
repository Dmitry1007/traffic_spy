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

    def responded_ins
      payloads.map {|payload| payload.responded_in}
    end
  end
end
