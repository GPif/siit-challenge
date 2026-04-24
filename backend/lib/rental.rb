require 'date'

class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :distance
  class << self
    def parse_json(hash)
      params = hash.transform_keys { |key| key.respond_to?(:to_sym) ? key.to_sym : key }
      new(
        id: params[:id],
        car_id: params[:car_id],
        start_date: Date.parse(params[:start_date]),
        end_date: Date.parse(params[:end_date]),
        distance: params[:distance]
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
    return @duration if @duration # As we cannot modify date

    @duration = (@end_date - @start_date).to_i + 1 #last day seems included
  end
end
