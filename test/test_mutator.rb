require 'ruckus'
require 'test/unit'

class TestMutator < Test::Unit::TestCase
  class TestMutation < Ruckus::Structure
    n32 :mfield, :value => Ruckus::Mutator.random_int(:width => 32, :seed => 0)
    n32 :field2, :value => 2
  end

  def test_mutator
    tm = TestMutation.new
    mut_int = tm.mfield.permute
    mfield, field2 = tm.to_s.unpack("NN")
    assert_equal(mut_int, mfield)
    assert_equal(mut_int, tm.mfield.value.to_i)
    assert_equal(2, field2)
    assert_equal(2, tm.field2.value)
    mut_int2 = tm.mfield.permute
    # assert_not_equal(mut_int, mut_int2)
    # assert_not_equal(mut_int, tm.mfield.value.to_i)
    assert_equal(mut_int2, tm.mfield.value.to_i)
    assert_equal(2, field2)
    assert_equal(2, tm.field2.value)
    mfield, field2 = tm.to_s.unpack("NN")
    assert_equal(2, field2)
    assert_equal(mut_int2, mfield)
  end
end