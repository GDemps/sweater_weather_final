class LatLon
  attr_reader :id,
              :lat,
              :lon,
              :status_code,
              :messages

  def initialize(data)
    @id = nil
    @status_code = data[:info][:statuscode]
    @messages = data[:info][:messages]
    if !data[:results][0][:locations][0].nil?
      @lat = data[:results][0][:locations][0][:latLng][:lat]
      @lon = data[:results][0][:locations][0][:latLng][:lng]
    end
  end
end
