require 'sinatra'
require "sinatra/json"
require "sinatra/reloader" if development?
require_relative 'lib/snapr.rb'
require 'pry-debugger'
require 'json'
# require 'rack/test'
enable :sessions
set :bind, '0.0.0.0'

get '/hello' do
  return "hello"
end
get '/' do
  send_file 'index.html'
end

# get '/user/:id' do
#   if session[:user_id] == params[:id]
#     return json Snapr::GetUserById.run(id: session[:user_id])
#   else
#     return :failure
#   end
# end

post '/login' do
  puts params

  params = JSON.parse(request.body.read.to_s)
  login_info = params['user']
  login_result = Snapr::UserLogin.run(login_info)

  if login_result[:success?]
    session[:user] = login_result[:username].id

  else
    @error = login_result[:error]
  end


  json( {user_id: login_result[:username].id } )

end

post '/signup' do
  puts params
  params = JSON.parse(request.body.read.to_s)
  signup_info = params['user']
  signup_result = Snapr::UserSignUp.run(signup_info)

  if signup_result[:success?]
    session[:user] = signup_result[:username].id
  else
    @error = signup_result[:error]
  end

   json( {user_id: signup_result[:username].id } )
end

post '/users/:id/profile' do
  if session[:user] == params[:id].to_i
    puts params
    params = JSON.parse(request.body.read.to_s)
    signup_info = params['user']
    signup_info['id'] = session[:user]
    profile_result = Snapr::CreateProfile.run(signup_info)
    return json( {user_id: profile_result[:profile].id } )

  else
    return json({error: 'failure'})
  end
end

# get 'users/:id/profile' do
#   if session[:id]
#     erb :profile
#   else
#     redirect to('/login')
#   end
# end

post '/users/:id/message/:idto' do
    params = JSON.parse(request.body.read.to_s)
    snap_result = Snapr::SendSnap.run(params)
    # return json( { snap_info: snap_result[:] } )
  # else
  #   return
  return json({:success => true})

  # end
end


post '/match' do
  params = JSON.parse(request.body.read.to_s)

  result = Snapr::InsertMatch.run(params)

  return json(result)
end

get '/users/:id/matches' do
  if session[:user] == params[:id].to_i
    result = Snapr::ViewMatches.run({id: session[:user]})

    @match_results = result[:matches]

    arr = []
    @match_results.each { |user| arr << {username: user.username, id: user.id, age: user.age, city: user.city, state: user.state, gender: user.gender, gender_pref: user.gender_pref, description: user.description, image: user.image} }

    return json arr

  else
    return json({error: 'failure'})
  end
end


get '/users/:id/feed' do

  if session[:user] == params[:id].to_i

    result = Snapr::ViewProfiles.run({id: session[:user]})

    @profiles = result[:profiles]
    arr = []
# binding.pry
    # signup_info['image'] = params[:tempfile]
    @profiles.each { |user| arr << {username: user.username, id: user.id, age: user.age, city: user.city, state: user.state, gender: user.gender, gender_pref: user.gender_pref, description: user.description, image: user.image} }
    return json arr

  else
    return json({error: 'failure'})
  end
end
