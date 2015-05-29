module TrafficSpy
  class UserAgent < ActiveRecord::Base
    belongs_to :payload
  end
end