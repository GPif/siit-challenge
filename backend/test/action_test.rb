require_relative 'test_helper'

class ActionTest < Test::Unit::TestCase
  def test_combine
    combined = Action.combine(
      [
        Action.new('drivy',  'credit', 1),
        Action.new('drivy',  'credit', 2),
        Action.new('driver', 'debit',  3)
      ]
    ).map(&:attributes)
    expected = [
      Action.new('drivy',  'credit', 3),
      Action.new('driver', 'debit',  3)
    ].map(&:attributes)
    assert_equal(expected, combined)
  end
end
