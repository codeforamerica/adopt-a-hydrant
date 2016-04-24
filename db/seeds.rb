User.where(email: 'john@example.com').first_or_initialize.tap do |user|
  user.first_name = 'John'
  user.last_name = 'Doe'
  user.password = 'password'
end

r = Random.new

500.times do |i|
  Thing.where(city_id: i).first_or_initialize.tap do |thing|
    thing.name = "Some Drain #{i}"
    thing.lat = r.rand(37.75..37.78)
    thing.lng = r.rand(-122.43..-122.41)
    thing.system_use_code = ['MS4', 'STORM', 'COMB', 'UNK'].sample
    thing.save!
  end
end
