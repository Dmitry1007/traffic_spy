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
      parsed_source = ParseSource.new(params)
      status parsed_source.status
      body parsed_source.body
    end
    
    post '/sources/:identifier/data' do
      parsed_source = TrafficSpy::ParsePayload.new(params[:payload]).validate
      status parsed_source.status
      body parsed_source.body
    end
    
    get '/sources/:identifier' do
      @source = Source.find_by(:identifier => params["identifier"])
      erb :dashboard
    end
  end
end
