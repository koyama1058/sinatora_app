require 'sinatra'
require 'sinatra/reloader'

get '/' do
  erb :index
end

get '/memo' do
  erb :index
end

get '/memo/new' do
  erb :new
end

get '/memo/edit' do
  erb :edit
end

get '/memo/show' do
  erb :show
end