require_relative 'test_helper'

class ApplicationTest < Test::Unit::TestCase
  def setup
    @app = Application.new(File.expand_path('../level5', __dir__))
  end

  def test_cars
    assert_equal 1, @app.cars.count
  end

  def test_rentals
    assert_equal 3, @app.rentals.count
  end

  def test_find_car!
    c = @app.find_car!(1)
    assert_equal 1, c.id
    assert_equal 2000, c.price_per_day
    assert_equal 10, c.price_per_km
  end

  def test_find_car_exception!
    assert_raise(RuntimeError) do
      @app.find_car!(2)
    end
  end

  def test_options_for
    options = @app.options_for(1)
    assert_equal 2, options.count
    assert(options.any? { |el| el.instance_of?(Option::Gps) })
    assert(options.any? { |el| el.instance_of?(Option::BabySeat) })
  end
end
