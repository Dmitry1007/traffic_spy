module TrafficSpy
  class Client < ActiveRecord::Base
    validates :identifier, :rootUrl, presence: true
  end
end