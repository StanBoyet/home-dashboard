class DashboardsController < ApplicationController

  def show
    uri = URI.parse("http://m.stib.be/api/getwaitingtimes.php?line=1&iti=2&halt=4303")

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    http_response = http.request(request)

    if http_response.code == '200'
      response = Hash.from_xml(http_response.body)
      next_passes = response['waitingtimes']
      @passes = []
      next_passes['waitingtime'].each do |pass|
        @passes << Pass.new(
          time: pass['minutes'],
          stop: next_passes['stopname']
        )
      end
    else
      flash['error'] = 'Request failed'
    end
  end

end
