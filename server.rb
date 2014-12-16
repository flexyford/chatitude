require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'pg'
require './lib/chatitude.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant

class Chatitude::Server < Sinatra::Application

get '/' do
  send_file 'public/index.html'
end

get '/chats' do 
	db = Chatitude.create_db_connection('chatitude_test')
	Chatitude::MessagesRepo.all(db)

end

post '/signup' do
	db = Chatitude.create_db_connection('chatitude_test')
	user_data = {'username' => params['username'], 'password' => params['password']}
	Chatitude::UsersRepo.signup(db, user_data)
	return
end

post '/signin' do
	username = params['username']
	password = params['password']
	user_data = {'username' => username, 'password' => password}
	db = Chatitude.create_db_connection('chatitude_test')
	Chatitude::UsersRepo.signin(db, user_data)
	return
end

post '/chats' do
	# Get user_id from api_token
	db = Chatitude.create_db_connection('chatitude_test')
	api_token = params['apiToken']
	user_id = Chatitude::UsersRepo.get_user(db, api_token)

	message_data = {'user_id' => user_id, 'message' => params['message']}
	Chatitude::MessagesRepo.save(db, message_data)
	return
end
end
