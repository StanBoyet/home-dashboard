class Weather
  attr_accessor :time, :temp_max, :temp_min, :temp, :sky, :icon, :description

  def initialize(time, temp_max, temp_min, temp, sky, icon, description)
    @time = time
    @temp_max = temp_max
    @temp_min = temp_min
    @temp = temp
    @sky = sky
    @icon = icon
    @description = description
  end

  def self.from_api(api_response)
    timestamp = api_response['dt']
    time = Time.at(timestamp).to_datetime
    temp = api_response['main']['temp']
    temp_min = api_response['main']['temp_min']
    temp_max = api_response['main']['temp_max']
    sky = api_response['weather'][0]['id']
    icon = api_response['weather'][0]['icon']
    description = api_response['weather'][0]['description']
    self.new(time, temp_max, temp_min, temp, sky, icon, description)
  end

  def self.next_n_from_api(n, api_response)
    @list = []
    n.times do |i|
      @list << self.from_api(api_response['list'][i])
    end
    @list
  end
end
