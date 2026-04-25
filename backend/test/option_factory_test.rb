require_relative 'test_helper'

class OptionFactoryTest < Test::Unit::TestCase
  def test_create_option
    assert_kind_of Option::BabySeat, Option::Factory.create('baby_seat')
    assert_kind_of Option::Gps, Option::Factory.create('gps')
    assert_kind_of Option::AdditionalInsurance, Option::Factory.create('additional_insurance')
    assert_raise(ArgumentError) { Option::Factory.create('invalid_option') }
  end
end
