require 'pg'

module Chatitude
	def self.clear_tables
    db.exec <<-SQL
      DELETE FROM users;
      DELETE FROM messages;
    SQL

	end

	def self.create_tables
    db.exec <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        username VARCHAR,
        "apiToken" VARCHAR
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

	def self.db
    PG.connect(host: 'localhost', dbname: 'chatitude_dev')
	end

	def self.drop_tables 
    db.exec <<-SQL
      DROP TABLE messages;
      DROP TABLE users;
    SQL
	end

	def self.seed_tables
    db.exec <<-SQL
      INSERT INTO users (username, password) VALUES ('Glenn', 'password123');
      INSERT INTO users (username, password) VALUES ('Alex', 'ford');
      INSERT INTO users (username, password) VALUES ('Michael', 'bash');
    SQL
	end
end