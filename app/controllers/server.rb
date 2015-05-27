module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      client = TrafficSpy::Client.new(params[:client])
      client.save
      {identifier: client.identifier}.to_json
    end
  end
end