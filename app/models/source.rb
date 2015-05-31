module TrafficSpy
  class Source < ActiveRecord::Base
    attr_reader :url
    
    validates_presence_of :identifier, :root_url
    validates :identifier, uniqueness: true
    has_many :payloads

    def determine_path(path)
      if path
        @url = (root_url + "/" + path)
      else
        @url = root_url
      end
    end

    def urls
      payloads.map { |payload| payload.url }
    end

    def user_agents
      payloads.map { |payload| payload.user_agent }
    end

    def responded_ins
      payloads.map {|payload| payload.responded_in}
    end
    
    def longest_response_time
      payloads.where(url: @url).maximum(:responded_in)
    end
    
    def shortest_response_time
      payloads.where(url: @url).minimum(:responded_in)
    end
    
    def average_response_time
      payloads.where(url: @url).average(:responded_in)
    end
    
    def verbs_used
      payloads.where(url: @url).uniq.pluck(:request_type) #review this one--not sure we totally understand how it works
    end
    
    def most_popular_referrers
      payloads.where(url: @url).group(:referred_by).order('referred_by desc').count(:referred_by).first(3)
    end
    
    def most_popular_browsers
      payloads.where(url: @url).group(:browser).order('browser desc').count(:browser).first(3)
    end
    
    def most_popular_operating_systems
      payloads.where(url: @url).group(:operating_system).order('operating_system desc').count(:operating_system).first(3)
    end
  end
end
