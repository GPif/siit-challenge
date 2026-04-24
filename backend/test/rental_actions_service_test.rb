require 'test/unit'
require_relative '../lib/rental'
require_relative '../lib/car'
require_relative '../lib/rental_actions_service'
require_relative '../lib/action'

class RentalActionsServiceTest < Test::Unit::TestCase
  def test_compute
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 2, car_id: 1, start_date: Date.new(2015, 7, 3), end_date: Date.new(2015, 7, 14), distance: 1000)
    expected = [
      Action.new('driver',    'debit',  27_800),
      Action.new('owner',     'credit', 19_460),
      Action.new('insurance', 'credit', 4170),
      Action.new('assistance','credit', 1200),
      Action.new('drivy',     'credit', 2970)
    ]
    assert_equal expected, RentalActionsService.new(car, rental).compute
  end
end
