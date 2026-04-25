class Commission
  attr_reader :insurance_fee, :assistance_fee, :drivy_fee

  def initialize(insurance_fee:, assistance_fee:, drivy_fee:)
    @insurance_fee = insurance_fee
    @assistance_fee = assistance_fee
    @drivy_fee = drivy_fee
  end

  def total
    @insurance_fee + @assistance_fee + @drivy_fee
  end

  def attributes
    { insurance_fee:, assistance_fee:, drivy_fee: }
  end
end
