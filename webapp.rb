require 'sinatra'
require 'data_mapper'

Datamapper::setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/dev.db")

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

get '/hello/:name/:city' do
	"Hello there, #{params[:name]} from #{params[:city]}."
end

get '/more/*' do
	params[:splat]
end

get '/form' do
	erb :form
end

#post '/form' do
#	'Hello again'
#end

post '/form' do
	"You submitted this '#{params[:message]}' "
end