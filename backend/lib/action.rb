class Action
  attr_reader :who, :type, :amount

  class << self
    def combine(actions)
      actions.group_by { |a| [a.who, a.type] }
             .map { |(who, type), group| new(who, type, group.sum(&:amount)) }
    end
  end

  def initialize(who, type, amount)
    @who    = who
    @type   = type
    @amount = amount
  end

  def attributes
    { who:, type:, amount: }
  end
end
