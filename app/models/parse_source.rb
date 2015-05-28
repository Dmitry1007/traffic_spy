module TrafficSpy
  class ParseSource
    def initialize(params)
      @source = Source.new(identifier: params["identifier"],
                           rootUrl:   params["rootUrl"])
    end

    def status
      if @source[:identifier] == nil || @source[:rootUrl] == nil
        400
      elsif @source.save
        200
      else
        403
      end
    end

    def body
      if @source.save
        "{'identifier':'#{@source[:identifier]}'}"
      else
        @source.errors.full_messages
      end
    end
  end
end