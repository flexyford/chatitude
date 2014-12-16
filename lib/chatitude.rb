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

    api1 = Chatitude::UsersRepo.signup(db, { 'username' => "Glenn", 'password' => 'password123' })
    api2 = Chatitude::UsersRepo.signup(db, { 'username' => "Alex", 'password' => 'ford' })
    api3 = Chatitude::UsersRepo.signup(db, { 'username' => "Michael", 'password' => 'bash' })

    userid1 = Chatitude::UsersRepo.get_user(db, api1 )['id']
    userid2 = Chatitude::UsersRepo.get_user(db, api2 )['id']
    userid3 = Chatitude::UsersRepo.get_user(db, api3 )['id']

    msg1 = Chatitude::MessagesRepo.save(db, { 'message' => "Hi", 'userId' => userid1 } )
    msg2 = Chatitude::MessagesRepo.save(db, { 'message' => "Hey", 'userId' => userid2 } )
    msg3 = Chatitude::MessagesRepo.save(db, { 'message' => "Hello", 'userId' => userid3 } )

	end
end

require_relative 'repos/user_repo'
require_relative 'repos/messages_repo'
