#! ruby

Dir[File.expand_path('../lib/**/*.rb', __dir__)].sort.each do |file|
  require file
end

require 'json'

# Load input data
input_body = JSON.parse(File.read('./data/input.json'))
# Parse cars and rentals from input data and place them in a variable
cars = input_body['cars'].map { |car| Car.new(car['id'], car['price_per_day'], car['price_per_km']) }
rentals = input_body['rentals'].map { |rental| Rental.parse_json(rental) }

res = {
  rentals: rentals.map do |rental|
    car = cars.find { |c| c.id == rental.car_id }
    raise "Car not found" unless car

    price = PriceService.new(car, rental).compute_with_discount
    {
      id: rental.id,
      price: price,
      commission: CommissionService.new(price, rental.duration).compute
    }
  end
}

puts JSON.pretty_generate(res)
File.write('./data/output.json', JSON.pretty_generate(res))
