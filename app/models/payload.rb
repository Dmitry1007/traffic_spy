module TrafficSpy
  class Payload < ActiveRecord::Base
    validates :sha, uniqueness: true
    validates_presence_of :sha, :url
    has_one :url
  end
end
