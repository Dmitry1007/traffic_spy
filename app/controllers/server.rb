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
      erb @dataset.url_view
    end
    
    get '/sources/:identifier/urls/:path' do |identifier, path|
      @source = Source.find_by(identifier: identifier)
      @final_path = @source.determine_path(path)
      erb :urlpage
    end

    get '/sources/:identifier/events' do |identifier|
      @source = Source.find_by(identifier: identifier)
      if @source.event_names.count == 0
        erb :event_error
      else
        @event_names = @source.event_names
        erb :event
      end
    end

    get '/sources/:identifier/events/:event_name' do |identifier, event_name|
      @source = Source.find_by(identifier: identifier)
      @identifier = identifier
      @event_name = event_name
      if @source.total_events_received(event_name) == 0
        erb :individual_event_error
      else
        @hourly_events = @source.hourly_events(event_name)
        @total_received   = @source.total_events_received(event_name)
        erb :eventdata
      end
    end
  end
end
