require_relative 'spec_helper.rb'
require 'pry-debugger'

describe Snapr::RateProfile do

  it "will return a false with a dislike" do
    # Set up our data
    user = Snapr.orm.create_user('alex', 'alex')
    user1 = Snapr.orm.create_user('jill', 'jill')
    match = Snapr::RateProfile.run({:uid => 1, :uid_2 => 2, :like => false})

    expect(match[:success?]).to eq(true)
    expect(match[:result]).to eq(false)
  end

  it "will return a true with a like" do
    # Set up our data
    user = Snapr.orm.create_user('alex', 'alex')
    user1 = Snapr.orm.create_user('jill', 'jill')
    match = Snapr::RateProfile.run({:uid => 1, :uid_2 => 2, :like => true})

    expect(match[:success?]).to eq(true)
    expect(match[:result]).to eq(true)
  end
end

describe Snapr::ViewMatches do
  it "will list of user objects that have liked user" do
    # Set up our data
    Snapr.orm.create_user('alex', 'alex')
    Snapr.orm.create_user('jill', 'jill')
    Snapr.orm.create_user('kate', 'kate')
    Snapr.orm.create_user('sarah', 'sarah')
    Snapr.orm.insert_match(1, 2, true)
    Snapr.orm.insert_match(3, 1, true)
    matches = Snapr::ViewMatches.run({:uid => 1})
    matches = matches[:matches]

    matches.map! { |user| user.username }

    expect(matches).to include('jill', 'kate')
    expect(matches).not_to include('sarah')
  end
end

describe Snapr::ViewProfiles do
  it "will list of user objects that have liked user" do
    # Set up our data
    Snapr.orm.create_user('alex', 'alex')
    Snapr.orm.create_user('jill', 'jill')
    Snapr.orm.create_user('kate', 'kate')
    Snapr.orm.create_user('sarah', 'sarah')
    Snapr.orm.create_user('caroline', 'caroline')
    Snapr.orm.insert_match(1, 2, true)
    Snapr.orm.insert_match(3, 1, true)
    Snapr.orm.insert_match(5, 1, false)
    profiles = Snapr::ViewProfiles.run({:uid => 1, :g_pref => 'female'})
    profiles = profiles[:profiles]

    profiles.map! { |user| user.username }

    expect(profiles).to include('jill', 'kate', 'sarah')
    expect(profiles).not_to include('caroline')
  end
end
