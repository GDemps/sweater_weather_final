class Image
  attr_reader :url, :id
  def initialize(image_data)
    @url = image_data[:results].first[:urls][:full]
    @id = nil
  end
end
