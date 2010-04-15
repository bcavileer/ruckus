require 'ruckus'
require 'test/unit'

class TestKlass < Ruckus::Structure
   n32 :decider, :decides => {
    1 => :test_sub_klass1,
    2 => :test_sub_klass2
  }
end

class TestSubKlass1 < TestKlass
  n32 :decider, :value => 1
  n32 :secondary_element
end

class TestSubKlass2 < TestKlass
  n32 :decider, :value => 2
  n32 :secondary_element
  n32 :secondary_decider, :decides => {
    1 => :test_nested_decide1,
    2 => :test_nested_decide2,
    3 => :test_nested_decide3
  }
end

class TestNestedDecide1 < TestSubKlass2
  n32 :secondary_decider, :value => 1
  n32 :ternary_element
end

class TestNestedDecide2 < TestSubKlass2
  n32 :secondary_decider, :value => 2
  n32 :ternary_element
end

class TestNestedDecide3 < TestSubKlass2
  n32 :secondary_decider, :value => 3
  n32 :ternary_element
end

class TestDecides < Test::Unit::TestCase
  def test_decides
    o, s = TestKlass.factory("\000\000\000\001\000\000\000\002\000\000\000\003\000\000\000\004")
    assert_equal("\000\000\000\003\000\000\000\004",s)
    assert_equal(TestSubKlass1, o.class)
    assert_equal(1,o.decider.value)
    
    o, s = TestKlass.factory("\000\000\000\002\000\000\000\002\000\000\000\003\000\000\000\004")
    assert_equal(TestNestedDecide3, o.class)
    assert_equal(4, o.ternary_element.value)

    s = (tnd2 = TestNestedDecide2.new).capture("\000\000\000\001\000\000\000\002\000\000\000\002\000\000\000\004")
    assert_equal("", s)
    
    # assert_equal(1, tnd2.decider.value)
    assert_equal(2, tnd2.secondary_element.value)
    assert_equal(2, tnd2.secondary_decider.value)
    assert_equal(4, tnd2.ternary_element.value)
    flunk("Scoping issues - fails until test classes can be brought into the TestDecides class' scope")
  end
end