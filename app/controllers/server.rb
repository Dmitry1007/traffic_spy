module TrafficSpy
  class Server < Sinatra::Base
    get '/' do
      erb :index
    end

    not_found do
      erb :error
    end

    post '/sources' do
      client = Client.new(params[:client])
      if client.save
        status 200
        body "Registration Successful"
      else
        status 403
        body client.errors.full_messages
      end
    end
  end
end
