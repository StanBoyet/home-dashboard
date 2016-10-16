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
      #@weather = Weather.from_api(response)
      @weathers = Weather.next_n_from_api(4, response)
    else
      flash['error'] = 'Weather request failed'
    end
  end

  def compute_bus_passes
    uri = URI.parse("http://m.stib.be/api/getwaitingtimes.php?line=1&iti=2&halt=4303")
    http_response = get_http_response(uri)

    if http_response.code == '200'
      response = Hash.from_xml(http_response.body)
      @passes = Buses::Pass.passes_from_api(response)
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
