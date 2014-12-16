require 'bcrypt'

module Chatitude
  class UsersRepo

    def self.all(db)
      sql = <<-SQL
        SELECT username
        FROM users
      SQL
      db.exec(sql).entries
    end

    def self.get_user(db, api_token)
      sql = <<-SQL
        SELECT id
        FROM users
        WHERE "apiToken" = $1
      SQL
      db.exec(sql, [apiToken]).entries.first
    end

    def self.signin(db, user_data)
      creds = {}
      sql = <<-SQL
        SELECT "apiToken"
        FROM users
        WHERE username = $1
      SQL
      api_token = db.exec(sql, [user_data['username']]).entries.first['apiToken']
      db_password = BCrypt::Password.new(api_token)
      if db_password == user_data['password'] 
        return api_token
      else
        return false
      end
    end

    def self.signup(db, user_data)
      api_token = BCrypt::Password.create(user_data['password'])
      sql = <<-SQL
        INSERT INTO users
        (username, "apiToken")
        VALUES
        ($1, $2)
      SQL
      db.exec(sql, [user_data['username'], api_token])
      api_token
    end
  end
end