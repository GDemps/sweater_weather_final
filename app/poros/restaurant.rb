class Restaurant
  attr_reader :name,
              :address
  def initialize(data)
    @name = data[:restaurants][0][:restaurant][:name]
    @address = data[:restaurants][0][:restaurant][:location][:address]
  end
end
