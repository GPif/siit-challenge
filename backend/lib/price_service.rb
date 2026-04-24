require_relative 'numeric_helper'

class PriceService
  include NumericHelper

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

  # New rules:
  # - price per day decreases by 10% after 1 day
  # - price per day decreases by 30% after 4 days
  # - price per day decreases by 50% after 10 days
  def compute_with_discount
    distance_component = @car.price_per_km * @rental.distance

    tiers = [1, 4, 10, Float::INFINITY]
    discount_rates = [0.0, 0.1, 0.3, 0.5]
    curr_floor = 0
    time_component = 0
    tiers.each_with_index do |tier_limit, index|
      tier = [@rental.duration - curr_floor, tier_limit - curr_floor].min # compute duration for current tier
      discount_rate = (1 - discount_rates[index])
      time_component += tier * discount_rate * @car.price_per_day

      break if tier_limit >= @rental.duration

      curr_floor = tier_limit
    end

    numeric_format(time_component + distance_component)
  end
end
