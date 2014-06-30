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


  describe "user_login" do
    it ""

  end

  describe "user_signup" do
  end

  describe "create_profile" do
  end

  # describe "update_image" do
  # end

  describe "insert_match" do
    context "compatible" do
      it "will add a compatibility indicator to two users" do
        Snapr.orm.create_user('alex', 'alex')
        Snapr.orm.create_user('jill', 'jill')
        match = Snapr.orm.insert_match(1, 2, false)

        expect(match).to eq false
      end
    end

    context "compatible" do
      it "will add a compatibility indicator to two users" do
        Snapr.orm.create_user('alex', 'alex')
        Snapr.orm.create_user('jill', 'jill')
        match = Snapr.orm.insert_match(1, 2, true)

        expect(match).to eq true
      end
    end
  end

  describe 'list_matches' do
    it 'will list matching users' do
      Snapr.orm.create_user('alex', 'alex')
      Snapr.orm.create_user('jill', 'jill')
      Snapr.orm.create_user('kate', 'kate')
      Snapr.orm.insert_match(1, 2, true)
      matches = Snapr.orm.list_matches(1)
      matches.map! { |user| user.username }

      expect(matches).to include('jill')
      expect(matches).not_to include('kate')
    end
  end

  describe 'list_potential' do
    it "lists potential matches" do
      Snapr.orm.create_user('alex', 'alex')
      Snapr.orm.create_profile(25, 'petaluma', 'male', 'female', 'Im so cool')
      Snapr.orm.create_user('jill', 'jill')
      Snapr.orm.create_user('kate', 'kate')
      Snapr.orm.create_user('sarah', 'sarah')
      Snapr.orm.insert_match(1, 2, false)
      potential = Snapr.orm.list_potential(1)
      potential.map! { |user| user.username }

      expect(potential).to include('kate', 'sarah')
      expect(potential).not_to include('jill')
    end
  end
end
