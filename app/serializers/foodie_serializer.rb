class FoodieSerializer
  include FastJsonapi::ObjectSerializer
  attributes :attributes, :restaurant
end
