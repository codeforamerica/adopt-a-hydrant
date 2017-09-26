require 'test_helper'

class ThingTest < ActiveSupport::TestCase
  test 'name profanity filter' do
    t = things(:thing_1)
    t.name = 'profane aids'
    assert_raises ActiveRecord::RecordInvalid do
      t.save!
    end
  end

  test 'detail link' do
    t = things(:thing_1)
    assert_nil t.detail_link
    t.system_use_code = 'MS4'
    assert_equal 'http://sfwater.org/index.aspx?page=399', t.detail_link
  end

  test 'adopted scope' do
    t = things(:thing_1)
    assert_equal 0, Thing.adopted.count
    t.user = users(:erik)
    t.save!
    assert_equal 1, Thing.adopted.count
  end

  test 'display_name' do
    t = things(:thing_1)
    t.name = 'foobar'
    assert_equal 'foobar', t.display_name
    t.user = users(:erik)
    t.adopted_name = 'baz'
    assert_equal 'baz', t.display_name
  end
end
