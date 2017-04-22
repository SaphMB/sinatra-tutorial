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