require 'ruckus'
require 'test/unit'

class TestReplace < Test::Unit::TestCase
  class TestReplaceKlass < Ruckus::Structure
    n32 :element_one, :value => 1
    n32 :element_two, :value => 2
    n32 :element_three, :value => 3
  end

  class TestReplaceSubKlass < TestReplaceKlass
    n32 :element_one, :value => 2
    n32 :element_two, :value => 1
    n32 :element_four, :value => 4
  end

  class TestReplaceStrKlass < TestReplaceKlass
    str :element_one, :value => "element_one", :size => "element_one".size
    str :element_four, :value => "element_four", :size => "element_four".size
  end

  def test_replace
    tk = TestReplaceKlass.new
    tsk = TestReplaceSubKlass.new
    assert_equal(1, tk.element_one.value)
    assert_equal(2, tk.element_two.value)
    assert_equal(3, tk.element_three.value)
    assert_equal(2, tsk.element_one.value)
    assert_equal(1, tsk.element_two.value)
    assert_equal(3, tsk.element_three.value)
    assert_equal(4, tsk.element_four.value)
  end
  
  def test_type_replace
    trsk = TestReplaceStrKlass.new
    assert_equal("element_one", trsk.element_one.value)
    assert_equal("element_four", trsk.element_four.value)
  end
end