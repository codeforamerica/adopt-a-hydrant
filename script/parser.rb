# Thanks to the example set at https://github.com/xml4r/libxml-ruby/wiki/Using-the-Reader-API
# http://snippets.dzone.com/posts/show/5051
# http://www.informit.com/articles/article.aspx?p=683059&seqNum=18

require 'rubygems'
require 'xml'

def extract(filename)
  return XML::Reader.file(filename, :options => XML::Parser::Options::NOBLANKS | XML::Parser::Options::NOENT)
end

#display a node's name: local and prefix
def display( node )
    return node.name, node.value
end

container = extract "../app/assets/xml/hydrants.xml"
prev_name = ""
seeds = ""

while container.read
  unless container.node_type == XML::Reader::TYPE_END_ELEMENT
    name, value = display container
    seeds << "Thing.create(:lng => " + value.to_s.split(",").first + ", " + ":lat => " + value.to_s.split(",")[1] + ")\n" if (prev_name == "coordinates") 
    prev_name = name
  end
end

File.open("../db/seeds.rb", 'w') {|f| f.write(seeds.chop) }
system("rake db:seed")
container.close