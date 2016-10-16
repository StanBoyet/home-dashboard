module Buses
  class Pass
    attr_accessor :time, :stop

    def initialize(time, stop)
      @time = time
      @stop = stop
    end

    def self.passes_from_api(api_response)
      next_passes = api_response['waitingtimes']
      passes = []
      next_passes['waitingtime'].each do |pass|
        passes << self.new( pass['minutes'], next_passes['stopname'] )
      end
      passes
    end

  end
end
