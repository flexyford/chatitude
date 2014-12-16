require './server'

# set up db tables
db = Chatitude.create_db_connection 'chatitude_dev'
Chatitude.create_tables db

# run web app
run Chatitude::Server
