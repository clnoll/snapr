require 'spec_helper'

describe "ORM" do
  before(:all) do
    Snapr.orm.instance_variable_set(:@db_adaptor, PG.connect(host: 'localhost', dbname: 'snapr-test') )
    Snapr.orm.delete_tables
    Snapr.orm.add_tables
  end

  before(:each) do
    RPS.orm.delete_tables
    RPS.orm.add_tables
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


end
