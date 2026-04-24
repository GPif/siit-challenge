require 'test/unit'
require_relative '../lib/commission_service'

class CommissionServiceTest < Test::Unit::TestCase
  def test_compute
    commission_service = CommissionService.new(27_800, 12)
    expected = {
      "insurance_fee": 4170,
      "assistance_fee": 1200,
      "drivy_fee": 2970
    }
    assert_equal expected, commission_service.compute
  end
end
