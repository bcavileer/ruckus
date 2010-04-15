require 'ruckus'
require 'test/unit'

class TestOverride < Test::Unit::TestCase
  class TestOverridden < Ruckus::Structure
    n32 :primary, :value => 1
    n32 :secondary, :value => 2
  end

  class TestOverrider < TestOverridden
    override :primary, 2
    override :secondary, 1
  end

  def test_override
    overridden = TestOverridden.new
    overrider = TestOverrider.new
    assert_equal(overridden.primary.value, 1)
    assert_equal(overridden.secondary.value, 2)
    assert_equal(overrider.primary.value, 2)
    assert_equal(overrider.secondary.value, 1)
  end
end
