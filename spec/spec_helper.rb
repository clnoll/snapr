require 'pry-debugger'
# Require our project, which in turns requires everything else
require_relative '../lib/snapr.rb'

RSpec.configure do |config|
  config.before(:all) do
    Snapr.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'snapr-test'))
    Snapr.orm.delete_tables
    Snapr.orm.add_tables
  end

  config.before(:each) do
    Snapr.orm.delete_tables
    Snapr.orm.add_tables
  end

  config.after(:all) do
    Snapr.orm.delete_tables
  end
end
