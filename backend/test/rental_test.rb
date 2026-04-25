require_relative 'test_helper'

class RentalTest < Test::Unit::TestCase
  def test_attributes
    r = Rental.new(id: 2, car_id: 1, start_date: Date.new(2017, 12, 14), end_date: Date.new(2017, 12, 18), distance: 550)
    expected = {
      id: 2,
      car_id: 1,
      start_date: Date.new(2017, 12, 14),
      end_date: Date.new(2017, 12, 18),
      distance: 550
    }
    assert_equal expected, r.attributes
  end

  def test_parse_json
    payload = {
      id: 2,
      car_id: 1,
      start_date: '2017-12-14',
      end_date: '2017-12-18',
      distance: 550
    }.transform_keys(&:to_s)
    r = Rental.parse_json(payload)
    expected = Rental.new(id: 2, car_id: 1, start_date: Date.new(2017, 12, 14), end_date: Date.new(2017, 12, 18), distance: 550)
    assert_equal expected.attributes, r.attributes
  end

  def test_duration
    r = Rental.new(id: 2, car_id: 1, start_date: Date.new(2017, 12, 14), end_date: Date.new(2017, 12, 18), distance: 550)
    assert_equal 5, r.duration
  end

end
