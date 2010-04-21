require 'test/unit'
require 'ruckus'

class TestRespondTo < Test::Unit::TestCase
  class TestRespondClass < Ruckus::Structure
    n32 :test_element, :value => 1
    tag_bit :tag?, :value => 1
    n32 :tagged_element, :value =>2, :tag => :tagged
  end
  
  def test_respond_to?
    trc = TestRespondClass.new
    assert(trc.respond_to?(:test_element))
    assert(trc.respond_to?(:tag?))
    assert(trc.respond_to?(:tagged_element))
    assert(trc.respond_to?(:tagged))
    assert(!trc.respond_to?(:not_a_value))
  end
end