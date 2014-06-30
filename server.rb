require 'sinatra'
require_relative 'lib/snapr.rb'
require 'pry-debugger'
# require 'rack/test'
enable :sessions
set :bind, '0.0.0.0'
