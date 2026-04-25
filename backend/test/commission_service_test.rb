require_relative 'test_helper'

class CommissionServiceTest < Test::Unit::TestCase
  def test_compute
    commission_service = CommissionService.new(27_800, 12)
    expected = Commission.new(insurance_fee: 4170, assistance_fee: 1200, drivy_fee: 2970)
    assert_equal expected.attributes, commission_service.compute.attributes
  end
end
