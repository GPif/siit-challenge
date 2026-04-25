require_relative 'test_helper'

class PriceServiceTest < Test::Unit::TestCase
  def test_compute
    car = Car.new(id: 1, price_per_day: 10, price_per_km: 1)
    rental = Rental.new(id: 2, car_id: 1, start_date: Date.new(2017, 12, 14), end_date: Date.new(2017, 12, 18), distance: 100)
    price_service = PriceService.new(car, rental)
    assert_equal 150, price_service.compute
  end

  def test_compute_with_discount
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental1 = Rental.new(id: 2, car_id: 1, start_date: Date.new(2015, 7, 3), end_date: Date.new(2015, 7, 14), distance: 1000)
    rental2 = Rental.new(id: 2, car_id: 1, start_date: Date.new(2015, 7, 3), end_date: Date.new(2015, 7, 10), distance: 1000)
    rental3 = Rental.new(id: 2, car_id: 1, start_date: Date.new(2015, 7, 3), end_date: Date.new(2015, 7, 3 ), distance: 1000)
    price_service1 = PriceService.new(car, rental1)
    price_service2 = PriceService.new(car, rental2)
    price_service3 = PriceService.new(car, rental3)
    assert_equal 27_800, price_service1.compute_with_discount # 10*1000 + 2000*(1 + 3*0.9 + 6*0.7 + 2*0.5)
    assert_equal 23_000, price_service2.compute_with_discount # 10*1000 + 2000*(1 + 3*0.9 + 4*0.7)
    assert_equal 12_000, price_service3.compute_with_discount # 10*1000 + 2000*1
  end
end
