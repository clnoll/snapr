require 'spec_helper'

describe "ORM" do
  before(:all) do
    Snapr.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'snapr-test') )
    Snapr.orm.delete_tables
    Snapr.orm.add_tables
  end

  before(:each) do
    Snapr.orm.delete_tables
    Snapr.orm.add_tables
  end

  it "should be an ORM" do
    expect(Snapr.orm).to be_a(Snapr::ORM)
  end

  it "is created with a db adaptor" do
    expect(Snapr.orm.db_adaptor).not_to be_nil
  end

  describe "create_user" do
    it "creates a user as a User object" do
      user1 = Snapr.orm.create_user('first_user', 'pw')
      user2 = Snapr.orm.create_user('second_user', 'pw')
      expect(user1).to be_a(Snapr::User)
      expect(user1.username).to eq('first_user')
      expect(user1.id).to be_a(Fixnum)
      expect(user2.username).to eq('second_user')
      expect(user2.id).to_not eq(user1.id)
    end
  end

  describe "get_user" do
    it "initializes the user as a User object if the user exists" do
      user1 = Snapr.orm.create_user('first_user', 'pw')
      user = Snapr.orm.get_user(user1.username)
      expect(user).to be_a(Snapr::User)
      expect(user.id).to eq(user1.id)
      expect(user.username).to eq(user1.username)
      expect(user.password).to eq(user1.password)
    end

    it "returns nil if the user doesn't exist" do
      user = Snapr.orm.get_user(22)
      expect(user).to be_nil
    end
  end

  describe "create_profile" do
    it "updates the user's profile" do
      user1 = Snapr.orm.create_user('first_user', 'pw')
      user = Snapr.orm.create_profile(user1.id, 88, 'Oakland', 'CA', 'male', 'women', 'hi there')
      expect(user).to be_a(Snapr::User)
      expect(user.age).to eq('88')
      expect(user.city).to eq('Oakland')
      expect(user.state).to eq('CA')
      expect(user.gender).to eq('male')
      expect(user.gender_pref).to eq('women')
      expect(user.description).to eq('hi there')
    end
  end

  # describe "update_image" do
  # end


end
