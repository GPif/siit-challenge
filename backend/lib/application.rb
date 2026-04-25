require 'json'

Dir[File.expand_path('**/*.rb', __dir__)].each do |file|
  require file
end

class Application
  def self.run(level_dir)
    new(level_dir).run
  end

  def initialize(level_dir)
    @dir = level_dir
    @input = JSON.parse(File.read(File.join(level_dir, 'data/input.json')))
  end

  def cars
    @cars ||= @input['cars'].map { |car| Car.new(id: car['id'], price_per_day: car['price_per_day'], price_per_km: car['price_per_km']) }
  end

  def rentals
    @rentals ||= @input['rentals'].map { |rental| Rental.parse_json(rental) }
  end

  def find_car!(id)
    cars.find { |c| c.id == id } || raise("Car not found: #{id}")
  end

  def options_for(rental_id)
    (@input['options'] || [])
      .select { |o| o['rental_id'] == rental_id }
      .map    { |o| Option::Factory.create(o['type']) }
  end

  def write_output(result)
    out = OutputFormatter.call(result)
    puts out
    File.write(File.join(@dir, 'data/output.json'), out)
  end
end
