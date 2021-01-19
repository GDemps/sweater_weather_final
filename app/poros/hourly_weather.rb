class HourlyWeather
  attr_reader :time,
              :temperature,
              :wind_speed,
              :wind_direction,
              :conditions,
              :icon
  def initialize(data)
    @time = Time.at(data[:dt]).strftime('%H:%M:%S')
    @temperature = data[:temp]
    @wind_speed = "#{data[:wind_speed]} mph"
    @wind_direction = "from #{find_wind_direction(data[:wind_deg])}"
    @conditions = data[:weather][0][:description]
    @icon = data[:weather][0][:icon]
  end

  def find_wind_direction(wind)
    sector = (((wind - 11.25) / 22.5) + 0.5).round
    compass_directions = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW']
    compass_directions[(sector.abs % 16)]
  end
end
