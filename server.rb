require 'sinatra'
require 'sinatra/reloader'
require 'rest-client'
require 'json'
require 'pg'

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
