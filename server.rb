require 'sinatra'
require "sinatra/json"
require "sinatra/reloader" if development?
require_relative 'lib/snapr.rb'
require 'pry-debugger'
# require 'rack/test'
enable :sessions
set :bind, '0.0.0.0'


get '/' do
  # erb :login
  send_file 'index.html'
end

post '/' do, provides: :json do
  puts params
  params = JSON.parse(request.body.read.to_s)
  login_info = params["username"]
  login_result = Snapr::UserLogin.run(login_info["username"])
  json login_result.to_json
  # if result[:success?]  <<<<<<< success test happens in js file?
  #   session[:id] = result[:id]
  #   redirect to("/#{session[:id]}")
  # else
  #   @error = result[:error]
  #   redirect to('/login')
  # end
end

get '/signup' do
  # erb :signup
  send_file '/partials/signup.html'
end

post '/signup' do
  puts params
  params = JSON.parse(request.body.read.to_s)
  signup_info = params['account']
  account = Snapr::UserSignup.run(signup_info['username'], signup_info['password'])
  json account.to_json
  # if result[:success?]
  #   session[:id] = result[:id]
  # else
  #   @error = result[:error]
  #   redirect to('/signup')
  end
end

post ':id/profile' do
  puts params
  params = JSON.parse(request.body.read.to_s)
  profile_info = params['profile']
  profile = Snapr::CreateProfile.run(profile_info['id'], profile_info['age'], profile_info['city'], profile_info['state'], profile_info['gender'], profile_info['gender_pref'], profile_info['description'])
  json profile.to_json
  # if session[:id]
  #   edit_profile = Snapr::CreateProfile.run({id: session[:id], age: params[:age], city: params[:city], state: params[:state], gender: params[:gender], gender_pref: params[:gender_pref], description: params[:description]})
  #   redirect to("/login")
  # else
  #   redirect to('/login')
  # end
end

get ':id/profile' do
  send_file '/partials/profile.html'
  # if session[:id]
  #   erb :profile
  # else
  #   redirect to('/login')
  # end
end

get '/:id/matches' do
  if session[:id]
    show_matches = RPS::ViewMatches.run({id: session[:id]})
    @match_results = show_matches[:profiles]
    erb :matches
  else
    redirect to('/login')
  end
end

get '/:id' do
  if session[:id]
    erb :potential_matches
  else
    redirect to('/login')
  end

  user = Snapr.orm.get_user(session[:id])

  result = Snapr::ViewProfiles(session[:id], user.gender_pref)

  @profiles = result[:profiles]
end
