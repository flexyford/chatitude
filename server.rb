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

  end

  post '/signup' do
    
  end

  post '/signin' do

  end

  post '/chats' do

  end
end
