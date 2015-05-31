module TrafficSpy
  class Payload < ActiveRecord::Base
    validates :sha, uniqueness: true
    validates :sha, presence: true
    belongs_to :source
  end
end
