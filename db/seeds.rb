# make fake plastic trees
  MANY = 1000

# rough box of Minneapolis:
  MINLAT = 44.906173
  MAXLAT = 45.012823
  MINLNG = -93.328630
  MAXLNG = -93.219110

  def fakelat
    rand(MINLAT..MAXLAT).round(6)
  end

  def fakelng
    rand(MINLNG..MAXLNG).round(6)
  end

MANY.times do |n|
  city_id = n+1
  Thing.create(city_id: city_id, lng: fakelng, lat: fakelat)
end
