#! ruby

require_relative '../lib/application'

class Level1 < Application
  def run
    res = {
      rentals: rentals.map do |rental|
        car = find_car!(rental.car_id)
        { id: rental.id, price: PriceService.new(car, rental).compute }
      end
    }
    write_output(res)
  end
end

Level1.run(__dir__)
