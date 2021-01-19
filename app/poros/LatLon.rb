class LatLon
  attr_reader :id,
              :name,
              :lat,
              :lon

  def initialize(data)
    @id = nil
    @name = format_name(data)
    if !data[:results][0][:locations][0].nil?
      @lat = data[:results][0][:locations][0][:latLng][:lat]
      @lon = data[:results][0][:locations][0][:latLng][:lng]
    end
  end

  private

  def format_name(location_data)
    location_data[:results].first[:locations].first[:adminArea5] +
    ', ' +
    location_data[:results].first[:locations].first[:adminArea3] +
    ' ' +
    location_data[:results].first[:locations].first[:adminArea1]
  end
end
