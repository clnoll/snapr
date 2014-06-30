require 'pg'
require 'pry-debugger'

module Snapr
  class ORM
    attr_reader :db_adaptor

    def initialize
      @db_adaptor = PG.connect(host: 'localhost', dbname: 'snapr')
    end

    def add_tables
      table_users = <<-SQL
      CREATE TABLE users(
        id SERIAL,
        username TEXT,
        password TEXT,
        age INTEGER,
        city TEXT,
        state TEXT,
        gender TEXT,
        gender_pref TEXT,
        PRIMARY KEY(id));
      SQL
      table_matches = <<-SQL
      CREATE TABLE matches(
        id SERIAL,
        user_id_1 INTEGER REFERENCES users(id),
        user_id_2 INTEGER REFERENCES users(id),
        likes BOOLEAN);
      SQL
      @db_adaptor.exec(table_users)
      @db_adaptor.exec(table_matches)
    end

    def delete_tables
      @db_adaptor.exec("DROP TABLE IF EXISTS users CASCADE")
      @db_adaptor.exec("DROP TABLE IF EXISTS matches")
    end


  end

  def self.orm
    @__orm_instance ||= ORM.new
  end
end
