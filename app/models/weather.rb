class Weather
  attr_accessor :time, :temp_max, :temp_min, :temp, :sky

  def initialize(api_response)

    timestamp = api_response['list'][0]['dt']
    time = Time.at(timestamp).to_datetime
    temp = api_response['list'][0]['main']['temp']
    temp_min = api_response['list'][0]['main']['temp_min']
    temp_max = api_response['list'][0]['main']['temp_max']
    sky = api_response['list'][0]['weather'][0]['id']

    @time = time
    @temp_max = temp_max
    @temp_min = temp_min
    @temp = temp
    @sky = sky

  end
end
