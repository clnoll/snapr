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
    edit_profile = Snapr::CreateProfile.run({id: session[:id], age: params[:age], city: params[:city], state: params[:state], gender: params[:gender], gender_pref: params[:gender_pref], description: params[:description]})
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
    show_matches = RPS::ViewMatches.run({id: session[:id]})
    @match_results = show_matches[:profiles]
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

  user = Snapr.orm.get_user(session[:id])

  result = Snapr::ViewProfiles(session[:id], user.gender_pref)

  @profiles = result[:profiles]
end
