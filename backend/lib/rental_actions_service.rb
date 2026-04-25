require_relative 'price_service'
require_relative 'commission_service'
require_relative 'option_actions_service'
require_relative 'action'

class RentalActionsService
  def initialize(car, rental, options = [])
    @car = car
    @rental = rental
    @options = options
  end

  def compute
    price          = PriceService.new(@car, @rental).compute_with_discount
    commission     = CommissionService.new(price, @rental.duration).compute
    option_actions = OptionActionsService.new(@options, @rental).compute
    owner_amount   = price - commission.total

    base_actions = [
      Action.new('driver',     'debit',  price),
      Action.new('owner',      'credit', owner_amount),
      Action.new('insurance',  'credit', commission.insurance_fee),
      Action.new('assistance', 'credit', commission.assistance_fee),
      Action.new('drivy',      'credit', commission.drivy_fee)
    ]
    Action.combine(base_actions + option_actions)
  end
end
