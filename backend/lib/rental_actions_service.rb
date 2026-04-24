require_relative 'price_service'
require_relative 'commission_service'
require_relative 'action'

class RentalActionsService
  def initialize(car, rental)
    @car = car
    @rental = rental
  end

  def compute
    price = PriceService.new(@car, @rental).compute_with_discount
    commission = CommissionService.new(price, @rental.duration).compute

    owner_amount = price - (price * 0.3).to_i

    [
      Action.new('driver',     'debit',  price),
      Action.new('owner',      'credit', owner_amount),
      Action.new('insurance',  'credit', commission[:insurance_fee]),
      Action.new('assistance', 'credit', commission[:assistance_fee]),
      Action.new('drivy',      'credit', commission[:drivy_fee])
    ]
  end
end
