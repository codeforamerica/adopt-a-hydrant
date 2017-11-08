require 'test_helper'

require 'adoption_mover'

class AdoptionMoverTest < ActiveSupport::TestCase
  test 'moves deleted adoptions to close by unadopted things' do
    deleted_adoption_to_be_moved = things(:thing_1).tap do |thing|
      thing.update!(user_id: users(:erik).id, adopted_name: 'hello', lat: '37.74092857302200', lng: '-122.422757295129000')
      thing.destroy!
    end
    unadopted_thing_to_be_moved_to = things(:thing_10).tap do |thing|
      thing.update!(user_id: nil, lat: '37.74093794334370', lng: '-122.42275720139800')
    end

    moved_adoptions = AdoptionMover.move_close_deleted_adoptions(Time.zone.parse('1 hour ago'), 5)

    assert_equal moved_adoptions[deleted_adoption_to_be_moved.id], unadopted_thing_to_be_moved_to.id

    # assert close deleted adoption moved
    unadopted_thing_to_be_moved_to.reload
    assert_equal unadopted_thing_to_be_moved_to.user_id, deleted_adoption_to_be_moved.user_id
    assert_equal unadopted_thing_to_be_moved_to.adopted_name, deleted_adoption_to_be_moved.adopted_name

    # original adoption removed
    deleted_adoption_to_be_moved.reload
    assert_nil deleted_adoption_to_be_moved.user_id
  end

  test 'does not consider adopted drains when moving deleted adoptions to close by unadopted things' do
    deleted_adoption_to_be_moved = things(:thing_1).tap do |thing|
      thing.update!(user_id: users(:erik).id, adopted_name: 'hello', lat: '37.74092857302200', lng: '-122.422757295129000')
      thing.destroy!
    end
    adopted_thing_to_ignore = things(:thing_10).tap do |thing|
      thing.update!(user_id: users(:dan).id, adopted_name: 'world', lat: '37.74093794334370', lng: '-122.42275720139800')
    end

    assert_equal AdoptionMover.move_close_deleted_adoptions(Time.zone.parse('1 hour ago'), 5), {}

    # original adoption unchanged
    deleted_adoption_to_be_moved.reload
    assert_equal deleted_adoption_to_be_moved.user_id, users(:erik).id
    assert_equal deleted_adoption_to_be_moved.adopted_name, 'hello'

    # assert close adoption unchanged
    adopted_thing_to_ignore.reload
    assert_equal adopted_thing_to_ignore.user_id, users(:dan).id
    assert_equal adopted_thing_to_ignore.adopted_name, 'world'
  end

  test 'does not consider unadopted, far away, drains when moving deleted adoptions to close by unadopted things' do
    deleted_adoption_to_be_moved = things(:thing_1).tap do |thing|
      thing.update!(user_id: users(:erik).id, adopted_name: 'hello', lat: '37.74092857302200', lng: '-122.422757295129000')
      thing.destroy!
    end
    thing_to_ignore = things(:thing_10).tap do |thing|
      thing.update!(user_id: nil, lat: '38.74093794334370', lng: '-122.42275720139800')
    end

    assert_equal AdoptionMover.move_close_deleted_adoptions(Time.zone.parse('1 hour ago'), 5), {}

    # original adoption unchanged
    deleted_adoption_to_be_moved.reload
    assert_equal deleted_adoption_to_be_moved.user_id, users(:erik).id
    assert_equal deleted_adoption_to_be_moved.adopted_name, 'hello'

    # assert far unadopted thing unchanged
    thing_to_ignore.reload
    assert_nil thing_to_ignore.user_id
  end
end
