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
      parsed_source = ParseSource.new(params)
      status parsed_source.status
      body parsed_source.body
    end
    
    post '/sources/:identifier/data' do
      TrafficSpy::ParsePayload.new(params[:payload])
    end
  end
end
