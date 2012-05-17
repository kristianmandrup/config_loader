require 'rspec'
require 'rails_config_loader'

SPEC_DIR = File.dirname(__FILE__)

module Rails
  def self.root
    File.join SPEC_DIR, 'fixtures'
  end
end

class LoadMe
  include ConfigLoader  
end

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  
end
