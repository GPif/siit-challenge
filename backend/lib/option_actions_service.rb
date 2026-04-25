require_relative 'action'

class OptionActionsService
  def initialize(options, rental)
    @options = options
    @rental = rental
  end

  def compute
    return [] if @options.empty?

    costs = @options.map { |o| [o.owner, o.daily_price * @rental.duration] }
    driver_debit = costs.sum(&:last)
    credits = costs.group_by(&:first)
                   .map { |owner, entries| Action.new(owner, 'credit', entries.sum(&:last)) }
    [Action.new('driver', 'debit', driver_debit), *credits]
  end
end
