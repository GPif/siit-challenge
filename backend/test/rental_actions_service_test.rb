require_relative 'test_helper'

class RentalActionsServiceTest < Test::Unit::TestCase
  def test_compute
    car = Car.new(id: 1, price_per_day: 2000, price_per_km: 10)
    rental = Rental.new(id: 2, car_id: 1, start_date: Date.new(2015, 7, 3), end_date: Date.new(2015, 7, 14), distance: 1000)
    expected = [
      { who: 'driver',     type: 'debit',  amount: 27_800 },
      { who: 'owner',      type: 'credit', amount: 19_460 },
      { who: 'insurance',  type: 'credit', amount: 4170   },
      { who: 'assistance', type: 'credit', amount: 1200   },
      { who: 'drivy',      type: 'credit', amount: 2970   }
    ]
    assert_equal expected, RentalActionsService.new(car, rental).compute.map(&:attributes)
  end
end
