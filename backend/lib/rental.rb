require 'date'

class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :distance

  class << self
    def parse_json(hash)
      new(
        id: hash['id'],
        car_id: hash['car_id'],
        start_date: Date.parse(hash['start_date']),
        end_date: Date.parse(hash['end_date']),
        distance: hash['distance']
      )
    end
  end

  def initialize(id:, car_id:, start_date:, end_date:, distance:)
    @id = id
    @car_id = car_id
    @start_date = start_date
    @end_date = end_date
    @distance = distance
  end

  def attributes
    {
      id: @id,
      car_id: @car_id,
      start_date: @start_date,
      end_date: @end_date,
      distance: @distance
    }
  end

  def duration
    @duration ||= (@end_date - @start_date).to_i + 1 # last day seems included
  end
end
