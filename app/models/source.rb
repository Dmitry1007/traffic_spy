require 'groupdate'

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
    
    def establish_event(event)
      @event = event
    end

    def urls
      payloads.map {|payload| payload.url}
    end

    def browsers
      payloads.map {|payload| payload.browser}
    end

    def operating_systems
      payloads.map {|payload| payload.operating_system}
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

    def event_names
      payloads.group(:event_name).count.sort_by{|_,v|v}.reverse
    end

    def total_events_received(event_name)
      payloads.where(event_name: event_name).count
    end

    def hourly_events(event_name)
      payloads.where(event_name: event_name).group_by_hour_of_day(:requested_at, format: "%l%p").count
    end
  end
end
