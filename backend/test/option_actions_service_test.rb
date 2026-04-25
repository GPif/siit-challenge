require_relative 'test_helper'

class OptionActionsServiceTest < Test::Unit::TestCase
  def test_compute
    rental = Rental.new(id: 2, car_id: 1, start_date: Date.new(2015, 7, 3), end_date: Date.new(2015, 7, 12), distance: 1000)
    options = [
      Option::AdditionalInsurance.new,
      Option::BabySeat.new,
      Option::Gps.new
    ]
    option_actions_service = OptionActionsService.new(options, rental)
    expected = [
      { amount: 17_000, type: 'debit',  who: 'driver' },
      { amount: 10_000, type: 'credit', who: 'drivy'  },
      { amount: 7000,   type: 'credit', who: 'owner'  }
    ]
    assert_equal expected, option_actions_service.compute.map(&:attributes)
  end

  def test_compute_with_empty_options
    rental = Rental.new(id: 2, car_id: 1, start_date: Date.new(2015, 7, 3), end_date: Date.new(2015, 7, 12), distance: 1000)
    options = []
    option_actions_service = OptionActionsService.new(options, rental)
    expected = []
    assert_equal expected, option_actions_service.compute.map(&:attributes)
  end
end
