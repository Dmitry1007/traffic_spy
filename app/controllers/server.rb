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
      TrafficSpy::ParsePayload.new(params[:payload])
    end
  end
end
