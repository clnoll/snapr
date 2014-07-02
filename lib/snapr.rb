# Create our module. This is so other files can start using it immediately
module Snapr
  def self.orm
    @__orm_instance ||= ORM.new
  end
end

# Require all of our project files
require_relative 'scripts/create_profile.rb'
require_relative 'scripts/rate_profiles.rb'
require_relative 'scripts/send_snap.rb'
require_relative 'scripts/user_login.rb'
require_relative 'scripts/user_signup.rb'
require_relative 'scripts/view_matches.rb'
require_relative 'scripts/view_profiles.rb'
require_relative 'snapr/user.rb'
require_relative 'snapr/orm.rb'


require 'pry-debugger'
