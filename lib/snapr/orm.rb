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
      table_join = <<-SQL
      CREATE
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

    def get_user_by_id(uid)
      list = <<-SQL
      SELECT *
      FROM users
      WHERE id = #{uid};
      SQL
      result = @db_adaptor.exec(list).first

      Snapr::User.new(result["username"], result["password"], result["id"].to_i)
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

    def insert_match(uid_1, uid_2, like)
      command = <<-SQL
        INSERT INTO matches (user_id_1, user_id_2, likes)
        VALUES (#{uid_1}, #{uid_2}, #{like})
        RETURNING likes;
      SQL

      output = @db_adaptor.exec(command).first
      if output['likes'] == 'f'
        return false
      else
        return true
      end
    end

    def list_matches(uid)
      command = <<-SQL
        SELECT *
        FROM users u
        JOIN matches m
        ON u.id = m.user_id_2
        OR u.id = m.user_id_1
        WHERE m.user_id_1 = #{uid}
        OR m.user_id_2 = #{uid}
        AND m.likes != 'f'
        EXCEPT
        SELECT *
        FROM users u
        JOIN matches m
        ON u.id = m.user_id_2
        OR u.id = m.user_id_1
        WHERE u.id = #{uid};
      SQL

      users = []
      output = @db_adaptor.exec(command)

      output.each do |user|
        users << Snapr::User.new(user['username'], user['password'], user['id'].to_i, user)
      end
      users
    end

    def list_potential(uid, g_pref)
      # command1 = <<-SQL
      #   SELECT * FROM users
      #   JOIN matches
      #   ON users.id != matches.user_id_1
      #   AND users.id != matches.user_id_2
      #   WHERE users.gender = '#{g_pref}'
      #   EXCEPT
      #   SELECT * from users
      #   join matches
      #   ON users.id = matches.user_id_1
      #   OR users.id = matches.user_id_2
      #   WHERE users.gender = '#{g_pref}'
      #   AND matches.likes = false;
      # SQL

      command1 = <<-SQL
        SELECT * FROM users;
      SQL

      users = []
      output1 = @db_adaptor.exec(command1)

      output1.each do |user|
        users << Snapr::User.new(user["username"], user['password'], user['id'], user)
      end

      users
    end
  end

  def self.orm
    @__orm_instance ||= ORM.new
  end
end
