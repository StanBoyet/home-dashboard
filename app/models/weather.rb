class Weather
  include ActiveModel::Model
  attr_accessor :time,
                :temp,
                :temp_max,
                :temp_min,
                :sky

end
