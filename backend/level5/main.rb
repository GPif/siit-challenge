#! ruby

require_relative '../lib/application'

class Level5 < Application
  def run
    res = {
      rentals: rentals.map do |rental|
        car = find_car!(rental.car_id)
        options = options_for(rental.id)
        {
          id: rental.id,
          options: options.map(&:name),
          actions: RentalActionsService.new(car, rental, options).compute.map(&:attributes)
        }
      end
    }
    write_output(res)
  end
end

Level5.run(__dir__)
