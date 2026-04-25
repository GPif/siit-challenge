#! ruby

require_relative '../lib/application'

class Level4 < Application
  def run
    res = {
      rentals: rentals.map do |rental|
        car = find_car!(rental.car_id)
        {
          id: rental.id,
          actions: RentalActionsService.new(car, rental).compute.map(&:attributes)
        }
      end
    }
    write_output(res)
  end
end

Level4.run(__dir__)
