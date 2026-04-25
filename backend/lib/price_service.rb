class PriceService
  Tier = Struct.new(:up_to, :discount_percent)

  TIERS = [
    Tier.new(1,               0),
    Tier.new(4,               10),
    Tier.new(10,              30),
    Tier.new(Float::INFINITY, 50)
  ].freeze

  def initialize(car, rental)
    @car = car
    @rental = rental
  end

  def compute
    time_component = @car.price_per_day * @rental.duration
    distance_component = @car.price_per_km * @rental.distance
    time_component + distance_component
  end

  def compute_with_discount
    distance_component = @car.price_per_km * @rental.distance
    time_component = compute_tier_discount(@rental.duration, @car.price_per_day)
    time_component + distance_component
  end

  private

  def compute_tier_discount(duration, price_per_day)
    floor = 0
    total = 0
    TIERS.each do |tier|
      days   = [duration - floor, tier.up_to - floor].min
      total += days * price_per_day * (100 - tier.discount_percent) / 100
      return total if tier.up_to >= duration

      floor  = tier.up_to
    end
    total
  end
end
