require 'libxml'

module Parser
  include LibXML
  
  class KMLParser
    # def extract(filename) #kml
    #   container = libxmlmethodthatreadsxmlfile(filename)
    #   return container
    # end
    # 
    # def pourOutData(container)
    #   #instantiate string here?
    #   for each placemark in container
    #     for each lng, lat in placemark
    #       lng = lng
    #       lat = lat
    #       string.append."Thing.create(:city_id => 1, :lng => ("lng" = lng), :lat => ("lat" = lat))\n"
    #   return string.truncatetrailing\n
    #  
    # def transform(container) #seeds.rb
    #   file = create("seeds.rb")
    #   file.append(pourOutData(container))
    #   file.close
    # end
    # 
    def load
      system("rake db:seed")
    end
    
    # def populateDatabase(filename)
    #   transform(extract(filename))
    #   load
    # end
  end
  
  program = KMLParser.new()
  program.populateDatabase()
end

#TODO: add error-checking
#TODO: refactor
#TODO: determine best place to store

#xml to object library can work with to string to seeds.rb