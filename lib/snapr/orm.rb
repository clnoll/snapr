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
        description TEXT,
        PRIMARY KEY(id));
      SQL
      table_matches = <<-SQL
      CREATE TABLE matches(
        id SERIAL,
        user_id_1 INTEGER REFERENCES users(id),
        user_id_2 INTEGER REFERENCES users(id),
        likes BOOLEAN,
        PRIMARY KEY(id));
      SQL
      @db_adaptor.exec(table_users)
      @db_adaptor.exec(table_matches)
    end

    def delete_tables
      @db_adaptor.exec("DROP TABLE IF EXISTS users CASCADE")
      @db_adaptor.exec("DROP TABLE IF EXISTS matches")
    end

    def create_user(username, password)
      add = <<-SQL
      INSERT INTO users(username, password)
      VALUES('#{username}', '#{password}')
      RETURNING *;
      SQL
      result = @db_adaptor.exec(add).first

      Snapr::User.new(result["username"], result["password"], result["id"].to_i)
    end

    def get_user(username)
      list = <<-SQL
      SELECT *
      FROM users
      WHERE username='#{username}'
      SQL
      result = @db_adaptor.exec(list).first

      if result
        Snapr::User.new(result["username"], result["password"], result["id"].to_i)
      end
    end

    def create_profile(uid, age, city, state, gender, gender_pref, description)
      update = <<-SQL
      UPDATE users
      SET
        age=#{age},
        city='#{city}',
        state='#{state}',
        gender='#{gender}',
        gender_pref='#{gender_pref}',
        description='#{description}'
      WHERE id=#{uid}
      RETURNING *;
      SQL
      result = @db_adaptor.exec(update).first
      # binding.pry

      Snapr::User.new(result["username"], result["password"], result["id"].to_i, result)

    end

    # def update_image - on hold
    # end

  end

  def self.orm
    @__orm_instance ||= ORM.new
  end
end
