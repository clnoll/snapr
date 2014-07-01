require 'sinatra'
require "sinatra/json"
require "sinatra/reloader" if development?
require_relative 'lib/snapr.rb'
require 'pry-debugger'
require 'json'
# require 'rack/test'
enable :sessions
set :bind, '0.0.0.0'


get '/' do
  send_file 'index.html'
end

post '/login' do
  puts params
  params = JSON.parse(request.body.read.to_s)
  login_info = params['user']
  login_result = Snapr::UserLogin.run(login_info)
  json login_result.to_json

  if login_result[:success?]
    session[:id] = login_result[:id]
  else
    @error = login_result[:error]
  end

  json ["hey"]
end


# get 'users/signup' do
#   erb :signup
# end

# post 'users/signup' do
#   if result[:success?]
#     session[:id] = result[:id]
#   else
#     @error = result[:error]
#     redirect to('/signup')
#   end
# end

# post 'users/:id/profile' do
#   if session[:id]
#     edit_profile = Snapr::CreateProfile.run({id: session[:id], age: params[:age], city: params[:city], state: params[:state], gender: params[:gender], gender_pref: params[:gender_pref], description: params[:description]})
#     redirect to("/login")
#   else
#     redirect to('/login')
#   end
# end

# get 'users/:id/profile' do
#   if session[:id]
#     erb :profile
#   else
#     redirect to('/login')
#   end
# end

# get 'users/:id/matches' do
#   if session[:id]
#     show_matches = RPS::ViewMatches.run({id: params[:id]})
#     @match_results = show_matches[:profiles]
#     @matches.map! { |user| json user.to_json }
#     erb :matches
#   else
#     redirect to('/login')
#   end
# end

# get 'users/:id' do
#   if session[:id]
#     erb :potential_matches
#   else
#     redirect to('/login')
#   end

#   user = Snapr.orm.get_user(session[:id])

#   result = Snapr::ViewProfiles({id: params[:id], g_pref: user.gender_pref})

#   @profiles = result[:profiles]

#   @profiles.map! { |user| json user.to_json }

#   @profiles
# end
