# www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.lint
  end
end
