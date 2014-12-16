
task :environment do
  require './lib/chatitude.rb'
end

task :console => :environment do
  require 'irb'
  ARGV.clear
  IRB.start
end


namespace :db do

  task :create do
    `createdb chatitude_dev`
    `createdb chatitude_test`
    puts "Created."
  end

  task :drop do
    `dropdb chatitude_dev`
    `dropdb chatitude_test`
    puts "Dropped."
  end

  task :create_tables => :environment do
    db1 = Chatitude.create_db_connection('chatitude_dev')
    db2 = Chatitude.create_db_connection('chatitude_test')
    Chatitude.create_tables(db1)
    Chatitude.create_tables(db2)
    puts "Created tables."
  end

  task :seed => :environment do 
    db1 = Chatitude.create_db_connection('chatitude_dev')
    db2 = Chatitude.create_db_connection('chatitude_test')
    Chatitude.seed_tables(db1)
    Chatitude.seed_tables(db2)
    puts "Seeded Users and Messages"
  end

  task :drop_tables => :environment do
    db1 = Chatitude.create_db_connection('chatitude_dev')
    db2 = Chatitude.create_db_connection('chatitude_test')
    Chatitude.drop_tables(db1)
    Chatitude.drop_tables(db2)
    puts "Dropped tables."
  end

  task :clear => :environment do
    # The test db clears all the time, so there's no point in doing it here.
    db1 = Chatitude.create_db_connection('chatitude_dev')
    db2 = Chatitude.create_db_connection('chatitude_test') 
    Chatitude.clear_tables(db1)
    Chatitude.clear_tables(db2)
    puts "Cleared tables."
  end

end
