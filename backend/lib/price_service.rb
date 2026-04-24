class PriceService
  def initialize(car, rental)
    @car = car
    @rental = rental
  end

  # The rental price is the sum of:
  # - A time component: the number of rental days multiplied by the car's price per day
  # - A distance component: the number of km multiplied by the car's price per km
  def compute
    time_component = @car.price_per_day * @rental.duration
    distance_component = @car.price_per_km * @rental.distance
    time_component + distance_component
  end
end
