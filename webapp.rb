require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/dev.db")

class Message
  include DataMapper::Resource
  property :id, Serial
  property :text, String
end

DataMapper.finalize
Message.auto_upgrade!

get '/' do
 'Hello, World!'
end

get '/hello/:name' do
  "Hello there, #{params[:name]}."
end

get '/hello/:name/:city' do
	"Hey there #{params[:name]} from #{params[:city]}."
end

get '/more/*' do
  params[:splat]
end

get '/messages/new' do
 erb :form
end

post '/messages' do
	message_text = params[:message]
	message = Message.new(text: message_text)
	message.save!
	if message.save!
		redirect '/messages'
		"Message saved"
	else
		"An error occured"
	end
end

get '/messages' do
  @messages = Message.all
  erb :index
end

get '/messages/:id' do
	@message = Message.get(params[:id])
	erb :show
end
 

get '/messages/:id/edit' do
	@message = Message.get(params[:id])
	erb :edit
end

put '/messages/:id' do
	message = Message.get(params[:id])
	message.text = params[:message]
	if message.save!
		redirect '/messages'
	else
		'An error occurred'
	end
end


