class DashboardsController < ApplicationController

  def show
    compute_bus_passes
    compute_weather_forecast
  end

  private

  def compute_weather_forecast
    brussels_id = 3337389
    uri = URI.parse("http://api.openweathermap.org/data/2.5/forecast?id=#{brussels_id}&APPID=#{ENV['WEATHERMAP_API_KEY']}&units=metric")
    http_response = get_http_response(uri)
    if http_response.code == '200'
      response = JSON.parse(http_response.body)
      # TODO
      # @weather = Weather.new(response)
      timestamp = response['list'][0]['dt']
      time = Time.at(timestamp).to_datetime
      temp = response['list'][0]['main']['temp']
      temp_min = response['list'][0]['main']['temp_min']
      temp_max = response['list'][0]['main']['temp_max']
      sky = response['list'][0]['weather'][0]['id']
      @weather = Weather.new(time: time, temp_max: temp_max, temp_min: temp_min, temp: temp, sky: sky)
    else
      flash['error'] = 'Weather request failed'
    end
  end

  def compute_bus_passes
    uri = URI.parse("http://m.stib.be/api/getwaitingtimes.php?line=1&iti=2&halt=4303")
    http_response = get_http_response(uri)

    if http_response.code == '200'
      response = Hash.from_xml(http_response.body)
      # TODO
      # @passes = Buses::Pass.initialize_passes(response)
      next_passes = response['waitingtimes']
      @passes = []
      next_passes['waitingtime'].each do |pass|
        @passes << Pass.new(
          time: pass['minutes'],
          stop: next_passes['stopname']
        )
      end
    else
      flash['error'] = 'Bus request failed'
    end
  end

  def get_http_response(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    http_response = http.request(request)
  end

end
