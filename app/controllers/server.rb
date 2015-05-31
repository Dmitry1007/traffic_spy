require 'pry'

module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
      status 403
      "That application url does not exist"
    end
    
    post '/sources' do
      source = TrafficSpy::ParseSource.new(params)
      status source.status
      body source.body
    end
    
    post'/sources/:identifier/data' do
      payload = TrafficSpy::ParsePayload.new(params)
      status payload.status
      body payload.body
    end
  end
end
