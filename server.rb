require 'sinatra'
require_relative 'lib/rps.rb'
require 'pry-debugger'
# require 'rack/test'
enable :sessions
set :bind, '0.0.0.0'
