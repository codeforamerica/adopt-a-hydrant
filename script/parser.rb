# Thanks to the example set at https://github.com/xml4r/libxml-ruby/wiki/Using-the-Reader-API
# http://snippets.dzone.com/posts/show/5051
# http://www.informit.com/articles/article.aspx?p=683059&seqNum=18
# http://www.ruby-doc.org/docs/ProgrammingRuby/html/tut_modules.html
# http://xml4r.github.com/libxml-ruby/rdoc/
# http://blog.codahale.com/2005/11/24/a-ruby-howto-writing-a-method-that-uses-code-blocks/
# http://libxml.rubyforge.org/svn/tags/REL_0_9_2/README

module Parser
  #require 'rubygems'
  require 'xml'

  def extract(nodes)
    return yield nodes
  end
  
  def transform(nodes)
    prev_name = ''
    seeds = ''
    # i = 0

    while nodes.read
      unless nodes.node_type == XML::Reader::TYPE_END_ELEMENT
        seeds << 'Thing.create(:lng => ' + nodes.value.to_s.split(',').first + ', ' + ':lat => ' + nodes.value.to_s.split(',')[1] + ")\n" if (prev_name == 'coordinates') 
        # seeds << 'thing_' + (i+=1).to_s + ":\n  lat: " + nodes.value.to_s.split(',')[1] + "\n  lng: " + nodes.value.to_s.split(',').first + "\n\n" if (prev_name == 'coordinates') 
        prev_name = nodes.name
      end
    end
    
    nodes.close
    # puts seeds.chop
    return seeds
  end
  
  def load(seeds)
    File.open('../db/seeds.rb', 'w') {|f| f.write(seeds.chop)}
<<<<<<< HEAD
    # File.open('../test/fixtures/things.yml', 'w') {|f| f.write(seeds.chop.chop)}
=======
>>>>>>> 33d62b7ee76a7f583e8ca4704a339626291fc8ef
    system('rake db:seed')
  end
  
  def transformLoad(nodes)
    load(transform(nodes))
  end
    
end

class Test
  include Parser
end

test = Test.new
test.transformLoad(test.extract('../app/assets/xml/hydrants.xml'){|nodes| XML::Reader.file("#{nodes}", :options => XML::Parser::Options::NOBLANKS | XML::Parser::Options::NOENT)})