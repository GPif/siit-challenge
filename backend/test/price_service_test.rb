require 'test/unit'
require_relative '../lib/rental'
require_relative '../lib/car'
require_relative '../lib/price_service'

class PriceServiceTest < Test::Unit::TestCase
  def test_compute
    car = Car.new(id: 1, price_per_day: 10, price_per_km: 1)
    rental = Rental.new(id: 2, car_id: 1, start_date: Date.new(2017, 12, 14), end_date: Date.new(2017, 12, 18), distance: 100)
    price_service = PriceService.new(car, rental)
    assert_equal 150, price_service.compute
  end

  def test_compute_with_discount
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 2, car_id: 1, start_date: Date.new(2015, 7, 3), end_date: Date.new(2015, 7, 14), distance: 1000)
    price_service = PriceService.new(car, rental)
    assert_equal 27_800, price_service.compute_with_discount
  end
end
