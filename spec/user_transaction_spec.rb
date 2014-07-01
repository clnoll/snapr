require 'spec_helper'

    # define dummy object by using Mocks
    # Your dummy object should have a method data that returns a hash with the key :logged
# expect_any_instance_of(Snapcat::Client).to receive(:login).and_return(DummyObject)

describe Snapr::UserSignUp do
  # it "signs up a user" do
  #   user_username = 'snaprtest'
  #   user_password = 'Snaprpassword'
  #   binding.pry
  #   # expect_any_instance_of(Snapcat::Client).to receive(:login).and_return(Snapcat::Client)
  #   result = Snapr::UserSignUp.run({ :username => user_username, :password => user_password })
  #   expect(result[:success?]).to eq(true)
  #   expect(result[:username].username).to eq('snaprtest')
  #   expect(result[:username].password).to eq('Snaprpassword')
  # end

  # it "errors if the user does not have a Snapchat account" do
  #   user_username = 'snapr_test'
  #   user_password = 'Snaprtest'
  #   result = Snapr::UserSignUp.run({ :username => user_username, :password => user_password, :date => '1990-01-20', :email => 'lizcojack2@gmail.com'})
  #   # binding.pry
  #   expect(result[:success?]).to eq(false)
  #   expect(result[:error]).to eq('Get Snapchat login')
  # end

  # it "errors if the user provides wrong password for Snapchat account" do
  #   user_username = 'snaprtest'
  #   user_password = 'Snaprtest2'
  #   result = Snapr::UserSignUp.run({ :username => user_username, :password => user_password, :date => '1990-01-20', :email => 'lizcojack2@gmail.com'})
  #   expect(result[:success?]).to eq(false)
  #   expect(result[:error]).to eq('Get Snapchat login')
  # end
end

describe Snapr::UserLogin do
  it "logs in a user" do
      user_username = 'snaprtest'
      user_password = 'Snaprpassword'
      create = Snapr::UserSignUp.run({ :username => user_username, :password => user_password })
      result = Snapr::UserLogin.run({ :username => user_username, :password => user_password })
      expect(result[:success?]).to eq(true)
      expect(result[:username].username).to eq('snaprtest')
      expect(result[:username].password).to eq('Snaprpassword')
  end

  # it "errors if the user provides the wrong password for snapchat account" do
  #     user_username = 'snaprtest'
  #     user_password = 'Snaprpassword2'
  #     create = Snapr::UserSignUp.run({ :username => user_username, :password => user_password })
  #     result = Snapr::UserLogin.run({ :username => user_username, :password => user_password })
  #     expect(result[:success?]).to eq(false)
  #     expect(result[:error]).to eq('Get Snapchat login')
  # end
end

describe Snapr::CreateProfile do
  it "creates a user profile" do
    user_username = 'snaprtest'
    user_password = 'Snaprpassword'
    create = Snapr::UserSignUp.run({ :username => user_username, :password => user_password })
    login = Snapr::UserLogin.run({ :username => user_username, :password => user_password })
    profile = Snapr::CreateProfile.run({ :id => login[:username].id, :age => 88, :city => 'Oakland', :state => 'CA', :gender => 'female', :gender_pref => 'female', :description => 'hi there'})
    expect(profile[:success?]).to eq(true)
    expect(profile[:profile].age).to eq('88')
    expect(profile[:profile].city).to eq('Oakland')
    expect(profile[:profile].state).to eq('CA')
    expect(profile[:profile].gender).to eq('female')
    expect(profile[:profile].gender_pref).to eq('female')
    expect(profile[:profile].description).to eq('hi there')
  end

  it "updates a user profile" do
    user_username = 'snaprtest'
    user_password = 'Snaprpassword'
    create = Snapr::UserSignUp.run({ :username => user_username, :password => user_password })
    login = Snapr::UserLogin.run({ :username => user_username, :password => user_password })
    profile = Snapr::CreateProfile.run({ :id => login[:username].id, :age => 88, :city => 'Oakland', :state => 'CA', :gender => 'female', :gender_pref => 'female', :description => 'hi there'})
    profile = Snapr::CreateProfile.run({ :id => login[:username].id, :age => 89, :city => 'Oakland', :state => 'CA', :gender => 'female', :gender_pref => 'female', :description => 'hi there'})
    expect(profile[:success?]).to eq(true)
    expect(profile[:profile].age).to eq('89')
    expect(profile[:profile].city).to eq('Oakland')
    expect(profile[:profile].state).to eq('CA')
    expect(profile[:profile].gender).to eq('female')
    expect(profile[:profile].gender_pref).to eq('female')
    expect(profile[:profile].description).to eq('hi there')
  end
end

describe Snapr::SendSnap do
  it "allows the user to send a snap to another user" do
    user_username = 'snaprtest'
    user_password = 'Snaprpassword'
    user2_username = 'al_hainesworth'
    user2_password = 'password'
    create = Snapr::UserSignUp.run({ :username => user_username, :password => user_password })
    login = Snapr::UserLogin.run({ :username => user_username, :password => user_password })
    user2 = Snapr::ORM.create_user(user2_username, user2_password)
    # profile = Snapr::CreateProfile.run({ :id => login[:username].id, :age => 88, :city => 'Oakland', :state => 'CA', :gender => 'female', :gender_pref => 'female', :description => 'hi there'})
    message = Snapr::SendSanp.run({ :recipient => user2.id })
  end

end
