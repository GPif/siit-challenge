#! ruby

require_relative '../lib/application'

class Level3 < Application
  def run
    res = {
      rentals: rentals.map do |rental|
        car = find_car!(rental.car_id)
        price = PriceService.new(car, rental).compute_with_discount
        {
          id: rental.id,
          price: price,
          commission: CommissionService.new(price, rental.duration).compute.attributes
        }
      end
    }
    write_output(res)
  end
end

Level3.run(__dir__)
