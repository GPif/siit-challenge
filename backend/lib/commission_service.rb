class CommissionService
  RATE = 30

  def initialize(price, duration)
    @price    = price
    @duration = duration
  end

  # We decide to take a 30% commission on the rental price to cover our costs and have a solid business model.
  # The commission is split like this:
  # - half goes to the insurance
  # - 1€/day goes to the roadside assistance
  # - the rest goes to us
  def compute
    commission     = @price * RATE / 100
    insurance_fee  = commission / 2
    assistance_fee = @duration * 100
    drivy_fee      = commission - insurance_fee - assistance_fee
    Commission.new(insurance_fee:, assistance_fee:, drivy_fee:)
  end
end
