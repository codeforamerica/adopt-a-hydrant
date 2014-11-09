FactoryGirl.define do
  factory :thing do
    lat { rand_lat }
    lng { rand_lng }
  end
end

def rand_lat
  minlat = 44.8907376794
  lat_range = 0.1602191585
  minlat + rand() * lat_range
end

def rand_lng
  minlng = -93.3285287744
  lng_range = 0.1239871577
  minlng + rand() * lng_range
end

