module TrafficSpy
  class Payload < ActiveRecord::Base
    validates :sha, uniqueness: true
    validates_presence_of :sha
    belongs_to :url
    belongs_to :source
    belongs_to :user_agent
  end
end
