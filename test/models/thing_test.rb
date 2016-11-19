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

  test 'loading drains, deletes existing drains not in data set, updates properties on rest' do
    thing_1 = things(:thing_1)
    thing_11 = things(:thing_11)

    fake_url = 'http://sf-drain-data.org'
    fake_response = [
      "PUC_Maximo_Asset_ID,Drain_Type,System_Use_Code,Location",
      "N-11,Catch Basin Drain,ABC,\"(37.75, -122.40)\"",
    ].join("\n")
    stub_request(:get, fake_url).to_return(body: fake_response)

    Thing.load_drains(fake_url)
    thing_11.reload

    # Asserts thing_1 is deleted
    assert_nil Thing.find_by(id: thing_1.id)

    # Asserts properties on thing_11 have been updated
    assert_equal thing_11.lat, BigDecimal.new(37.75, 16)
    assert_equal thing_11.lng, BigDecimal.new(-122.40, 16)
  end
end
