require 'sinatra'
require_relative 'lib/snapr.rb'
require 'pry-debugger'
# require 'rack/test'
enable :sessions
set :bind, '0.0.0.0'


get '/' do
  erb: login
end

post '/' do
  if result[:success?]
    session[:id] = result[:id]
  else
    @error = result[:error]
    redirect to('/login')
  end
end

get '/signup' do
  erb: signup
end

post '/signup' do
  if result[:success?]
    session[:id] = result[:id]
  else
    @error = result[:error]
    redirect to('/signup')
  end
end

post ':id/profile' do
  if session[:id]
    erb: potential_matches
  else
    redirect to('/login')
  end
end

get ':id/profile' do
    if session[:id]
    erb: profile
  else
    redirect to('/login')
  end
end

get '/:id/matches' do
  if session[:id]
    erb: matches
  else
    redirect to('/login')
  end
end

get '/:id' do
  if session[:id]
    erb: potential_matches
  else
    redirect to('/login')
  end
end
