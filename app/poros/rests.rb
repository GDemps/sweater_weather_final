class Rests
  attr_reader :name,
               :address

  def initialize(data)
    @restaurant = data[:businesses][0][:name]
    @address = data[:businesses][0][:location][:display_address][0]
  end
end
