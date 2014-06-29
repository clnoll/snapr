require 'pry-debugger'
# Require our project, which in turns requires everything else
require_relative '../lib/snapr.rb'

RSpec.configure do |config|
  RPS.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'snapr-test') )
end
