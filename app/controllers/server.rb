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
      client = TrafficSpy::Client.new(params)
      client.save
      {identifier: client.identifier}.to_json
    end
    
    post '/sources/:identifier/data' do
      payload = TrafficSpy::Payload.new(request.params)
      payload.save
      if duplicate_request_check(request.params)
        status 403
        "whatever"
      else
        
      end
    end
    
    def duplicate_request_check(params)
      binding.pry
      TrafficSpy::Payload.any? do |p|
        p.to_h == params
      end
    end
  end
end
