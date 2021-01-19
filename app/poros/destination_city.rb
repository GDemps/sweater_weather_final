class DestinationCity
  attr_reader :name

  def initialize(destination)
    @name = destination.name
    require "pry"
    binding.pry
  end
end
