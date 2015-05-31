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
    
    post '/sources/:identifier/data' do |identifier|
      source = Source.find_by(identifier: identifier)
      payload = TrafficSpy::ParsePayload.new(params[:payload], source)
      status payload.status
      body payload.body
    end
    
    get '/sources/:identifier' do |identifier|
      source = Source.find_by(identifier: identifier)
      @dataset = Dashboard.new(source)
      erb @dataset.view
    end
  end
end
