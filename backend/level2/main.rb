#! ruby

require_relative '../lib/application'

class Level2 < Application
  def run
    res = {
      rentals: rentals.map do |rental|
        car = find_car!(rental.car_id)
        { id: rental.id, price: PriceService.new(car, rental).compute_with_discount }
      end
    }
    write_output(res)
  end
end

Level2.run(__dir__)
