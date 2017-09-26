require 'test_helper'

require 'thing_importer'

class ThingImporterTest < ActiveSupport::TestCase
  test 'import does not modify data if endpoint fails' do
    thing1 = things(:thing_1)

    fake_url = 'http://sf-drain-data.org'
    stub_request(:get, fake_url).to_return(status: [500, 'Internal Server Error'], body: nil)
    assert_raises OpenURI::HTTPError do
      ThingImporter.load(fake_url)
    end
    assert_not_nil Thing.find(thing1.id)
  end

  test 'loading things, deletes existing things not in data set, updates properties on rest' do
    admin = users(:admin)
    thing1 = things(:thing_1)
    thing11 = things(:thing_11)
    thing10 = things(:thing_10).tap do |thing|
      thing.update!(name: 'Erik drain', user_id: users(:erik).id)
    end
    things(:thing_9).tap do |thing|
      thing.update!(user_id: users(:erik).id)
    end

    deleted_thing = things(:thing_3)
    deleted_thing.destroy!

    fake_url = 'http://sf-drain-data.org'
    fake_response = [
      'PUC_Maximo_Asset_ID,Drain_Type,System_Use_Code,Location',
      'N-3,Catch Basin Drain,ABC,"(42.38, -71.07)"',
      'N-10,Catch Basin Drain,DEF,"(36.75, -121.40)"',
      'N-11,Catch Basin Drain,ABC,"(37.75, -122.40)"',
      'N-12,Catch Basin Drain,DEF,"(39.75, -121.40)"',
    ].join("\n")
    stub_request(:get, fake_url).to_return(body: fake_response)

    ThingImporter.load(fake_url)

    email = ActionMailer::Base.deliveries.last
    assert_equal email.to, [admin.email]
    assert_equal email.subject, 'Adopt-a-Drain San Francisco import (1 adopted drains removed, 1 drains added, 7 unadopted drains removed)'
    thing11.reload
    thing10.reload

    # Asserts thing_1 is deleted
    assert_nil Thing.find_by(id: thing1.id)

    # Asserts thing_3 is reified
    assert_equal Thing.find_by(city_id: 3).id, deleted_thing.id

    # Asserts creates new thing
    new_thing = Thing.find_by(city_id: 12)
    assert_not_nil new_thing
    assert_equal new_thing.lat, BigDecimal.new(39.75, 16)
    assert_equal new_thing.lng, BigDecimal.new(-121.40, 16)

    # Asserts properties on thing_11 have been updated
    assert_equal thing11.lat, BigDecimal.new(37.75, 16)
    assert_equal thing11.lng, BigDecimal.new(-122.40, 16)

    # Asserts properties on thing_10 have been updated
    assert_equal 'Catch Basin Drain', thing10.name
    assert_equal BigDecimal.new(36.75, 16), thing10.lat
    assert_equal BigDecimal.new(-121.40, 16), thing10.lng
  end
end
