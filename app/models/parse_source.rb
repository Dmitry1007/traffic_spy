module TrafficSpy
  class ParseSource
    attr_accessor :status, :body
    
    def initialize(params)
      create(params)
    end

    def create(params)
      source = Source.new({identifier: params[:identifier], root_url: params[:rootUrl]})
      if source.save
        @status = 200
        @body = {"identifier":"#{source.identifier}"}.to_json
      else
        review(source)
      end
    end
    
    def review(source)
      if Source.exists?(identifier: source.identifier)
        @status = 403
        @body = "That identifier is already in use"
      elsif source.identifier == nil && source.root_url == nil
        @status = 400
        @body = "Please enter an identifier and a root url"
      elsif source.identifier == nil
        @status = 400
        @body = "Please enter an identifier"
      else
        @status = 400
        @body = "Please enter a root url"
      end
    end
  end
end
