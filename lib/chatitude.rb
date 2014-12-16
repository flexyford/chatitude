require 'pg'
require 'bcrypt'

module Chatitude
	def self.clear_tables(db)
    db.exec <<-SQL
      DELETE FROM users;
      DELETE FROM messages;
    SQL

	end

	def self.create_tables(db)
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        "apiToken" VARCHAR,
        username VARCHAR,
        password VARCHAR
        );
      CREATE TABLE IF NOT EXISTS messages (
        id SERIAL PRIMARY KEY,
        message VARCHAR,
        "userId" INTEGER REFERENCES users(id)
          ON DELETE CASCADE
          ON UPDATE CASCADE,
        time TIMESTAMP
        );
    SQL
	end

  def self.create_db_connection(dbname)
    PG.connect(host: 'localhost', dbname: dbname)
  end

	def self.drop_tables(db) 
    db.exec <<-SQL
      DROP TABLE messages;
      DROP TABLE users;
    SQL
	end

	def self.seed_tables(db)
    apiToken1 = BCrypt::Password.create("password123")
    apiToken2 = BCrypt::Password.create('ford')
    apiToken3 = BCrypt::Password.create('bash')


    db.exec( "INSERT INTO users (username, \"apiToken\") VALUES ('Glenn',   $1)",   [apiToken1] )
    db.exec( "INSERT INTO users (username, \"apiToken\") VALUES ('Alex',   $1)",    [apiToken2] )
    db.exec( "INSERT INTO users (username, \"apiToken\") VALUES ('Michael',   $1)", [apiToken3] )

	end
end
